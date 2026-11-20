
  (function() {
    const searchInput = document.getElementById('table-search-input');
    const filterButtons = document.querySelectorAll('#status-filter-group .filter-btn');
    const tableBody = document.getElementById('requests-table-body');
    let allRequests = [];
    let currentFilter = 'all';

    async function loadRequests() {
      try {
        const userStr = window.localStorage.getItem('currentUser');
        if (!userStr) return;
        const user = JSON.parse(userStr);

        const response = await fetch('api/student_requests.php?student_id=' + user.id);
        const data = await response.json();
        if (data.success) {
          allRequests = data.requests;
          renderTable();
        }
      } catch (err) {
        console.error(err);
      }
    }

    function renderTable() {
      const query = (searchInput ? searchInput.value : '').toLowerCase().trim();
      tableBody.innerHTML = '';

      const filtered = allRequests.filter(req => {
        let statusTag = 'processing';
        if (req.status === 'Completed') statusTag = 'completed';
        else if (req.status === 'Declined') statusTag = 'declined';
        else if (req.status === 'Pending Review') statusTag = 'review';
        
        const matchesFilter = currentFilter === 'all' || statusTag === currentFilter;
        const matchesQuery = !query || 
          (req.tracking_code && req.tracking_code.toLowerCase().includes(query)) ||
          (req.document_name && req.document_name.toLowerCase().includes(query));

        return matchesFilter && matchesQuery;
      });

      if (filtered.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="6" class="py-space-md text-center text-on-surface-variant font-body-md">No requests found.</td></tr>';
        return;
      }

      filtered.forEach(req => {
        const tr = document.createElement('tr');
        tr.className = 'hover:bg-surface-container-low/50 transition-colors request-row';

        let statusBadge = '';
        if (req.status === 'Processing') {
          statusBadge = `<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-primary-container text-on-primary font-label-md text-label-md font-semibold"><span class="w-1.5 h-1.5 rounded-full bg-on-primary animate-ping"></span> Processing</span>`;
        } else if (req.status === 'Ready for Pickup') {
          statusBadge = `<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-surface-container-high text-on-surface font-label-md text-label-md font-semibold"><span class="w-1.5 h-1.5 rounded-full bg-primary"></span> Ready for Pick-Up</span>`;
        } else if (req.status === 'Completed') {
          statusBadge = `<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-surface-container-low text-on-surface-variant font-label-md text-label-md font-semibold"><span class="material-symbols-outlined text-[14px]">done_all</span> Completed</span>`;
        } else if (req.status === 'Pending Review') {
          statusBadge = `<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-error-container text-on-error-container font-label-md text-label-md font-semibold"><span class="material-symbols-outlined text-[14px]">schedule</span> Pending Review</span>`;
        } else {
          statusBadge = `<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-surface-container text-outline font-label-md text-label-md font-semibold"><span class="material-symbols-outlined text-[14px]">archive</span> Declined</span>`;
        }

        const date = new Date(req.created_at).toLocaleString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit' });

        tr.innerHTML = `
          <td class="py-space-md px-space-lg">
            <div class="flex flex-col">
              <span class="font-code-sm text-code-sm font-bold text-primary">${req.tracking_code}</span>
              <span class="font-body-sm text-body-sm text-outline">${date}</span>
            </div>
          </td>
          <td class="py-space-md px-space-lg">
            <div class="flex items-center gap-space-sm">
              <div class="w-8 h-8 rounded-lg bg-surface-container flex items-center justify-center text-primary">
                <span class="material-symbols-outlined text-[18px]">description</span>
              </div>
              <div class="flex flex-col">
                <span class="font-headline-sm text-headline-sm text-on-surface">${req.document_name}</span>
                <span class="font-body-sm text-body-sm text-on-surface-variant">${req.document_category}</span>
              </div>
            </div>
          </td>
          <td class="py-space-md px-space-lg">
            <span class="font-body-md text-body-md text-on-surface">${req.fulfillment_method === 'pickup' ? 'Campus Pick-up' : 'Courier Delivery'}</span>
          </td>
          <td class="py-space-md px-space-lg">
            <div class="flex flex-col">
              <span class="font-code-sm text-code-sm font-semibold text-on-surface">₱${parseFloat(req.total_fee || 0).toFixed(2)}</span>
            </div>
          </td>
          <td class="py-space-md px-space-lg">
            ${statusBadge}
          </td>
          <td class="py-space-md px-space-lg text-right">
            <button class="btn-details px-space-sm py-1 rounded-lg bg-surface-container-low text-on-surface font-label-md text-label-md hover:bg-surface-container transition-colors" type="button" data-id="${req.id}">Details</button>
          </td>
        `;
        tableBody.appendChild(tr);
      });
      // Attach details modal listeners
      document.querySelectorAll('.btn-details').forEach(btn => {
        btn.addEventListener('click', (e) => {
          const reqId = parseInt(e.currentTarget.getAttribute('data-id'));
          const req = allRequests.find(r => r.id === reqId);
          if (req) showModal(req);
        });
      });
    }

    // Modal creation and logic
    function showModal(req) {
      let modal = document.getElementById('details-modal');
      if (!modal) {
        modal = document.createElement('div');
        modal.id = 'details-modal';
        modal.className = 'fixed inset-0 z-50 hidden items-center justify-center bg-black/50 backdrop-blur-sm p-4';
        modal.innerHTML = `
          <div class="bg-surface-container-lowest rounded-2xl shadow-2xl max-w-lg w-full overflow-hidden flex flex-col transform transition-all">
            <div class="bg-primary-container text-on-primary p-space-md flex items-center justify-between">
              <div class="flex items-center gap-space-xs">
                <span class="material-symbols-outlined text-[22px]">receipt_long</span>
                <span class="font-headline-sm text-headline-sm font-bold">Request Details</span>
              </div>
              <button type="button" id="close-modal-btn" class="text-on-primary hover:text-white transition-colors">
                <span class="material-symbols-outlined text-[20px]">close</span>
              </button>
            </div>
            <div class="p-space-md flex flex-col gap-space-md" id="modal-body-content"></div>
          </div>
        `;
        document.body.appendChild(modal);
        document.getElementById('close-modal-btn').addEventListener('click', () => {
          modal.classList.add('hidden');
          modal.classList.remove('flex');
        });
      }

      const date = new Date(req.created_at).toLocaleString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit' });
      const method = req.fulfillment_method === 'pickup' ? 'Campus Pick-up' : 'Courier Delivery';
      
      document.getElementById('modal-body-content').innerHTML = `
        <div class="flex flex-col gap-2">
          <div class="flex justify-between items-center border-b border-surface-container-high pb-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Tracking Code</span>
            <span class="font-code-sm text-code-sm font-bold text-primary">${req.tracking_code}</span>
          </div>
          <div class="flex justify-between items-center border-b border-surface-container-high pb-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Date Requested</span>
            <span class="font-body-sm text-body-sm text-on-surface">${date}</span>
          </div>
          <div class="flex justify-between items-center border-b border-surface-container-high pb-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Document</span>
            <span class="font-headline-sm text-body-sm font-semibold text-on-surface text-right">${req.document_name}</span>
          </div>
          <div class="flex justify-between items-center border-b border-surface-container-high pb-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Fulfillment</span>
            <span class="font-body-sm text-body-sm text-on-surface">${method}</span>
          </div>
          <div class="flex justify-between items-center border-b border-surface-container-high pb-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Total Fee</span>
            <span class="font-headline-sm text-body-sm font-bold text-primary">₱${parseFloat(req.total_fee || 0).toFixed(2)}</span>
          </div>
          <div class="flex justify-between items-center pt-2">
            <span class="font-label-sm text-label-sm text-outline uppercase tracking-wider">Status</span>
            <span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-surface-container-high text-on-surface font-label-md text-label-md font-semibold">${req.status}</span>
          </div>
        </div>
      `;
      
      modal.classList.remove('hidden');
      modal.classList.add('flex');
    }

    if (searchInput) searchInput.addEventListener('input', renderTable);

    filterButtons.forEach(btn => {
      btn.addEventListener('click', function() {
        filterButtons.forEach(b => {
          b.classList.remove('bg-primary-container', 'text-on-primary');
          b.classList.add('bg-surface-container-low', 'text-on-surface-variant');
        });
        this.classList.remove('bg-surface-container-low', 'text-on-surface-variant');
        this.classList.add('bg-primary-container', 'text-on-primary');

        currentFilter = this.getAttribute('data-filter');
        renderTable();
      });
    });

    loadRequests();
  })();
