
    (function() {
      // Data state
      const state = {
        selectedItems: [
          { id: 'tor', name: 'Transcript of Records (TOR)', price: 150, copies: 1 }
        ],
        fulfillment: 'pickup',
        payment: 'GCash'
      };

      const docGrid = document.getElementById('documentGrid');
      const cartContainer = document.getElementById('cartItemsContainer');
      const selectedCountBadge = document.getElementById('selectedCountBadge');
      const subtotalText = document.getElementById('subtotalText');
      const grandTotalText = document.getElementById('grandTotalText');
      const fulfillmentFee = document.getElementById('fulfillmentFee');
      const fulfillmentFeeLabel = document.getElementById('fulfillmentFeeLabel');
      const pickupLocationNote = document.getElementById('pickupLocationNote');
      const clearCartBtn = document.getElementById('clearCartBtn');

      function calculateTotals() {
        const subtotal = state.selectedItems.reduce((acc, item) => acc + (item.price * item.copies), 0);
        const deliveryFee = state.fulfillment === 'delivery' ? 120 : 0;
        const grandTotal = subtotal + deliveryFee;

        subtotalText.textContent = `₱${subtotal.toFixed(2)}`;
        fulfillmentFee.textContent = `₱${deliveryFee.toFixed(2)}`;
        grandTotalText.textContent = `₱${grandTotal.toFixed(2)}`;
        
        const count = state.selectedItems.length;
        selectedCountBadge.textContent = `${count} ${count === 1 ? 'Item' : 'Items'} Selected`;

        renderCart();
      }

      function renderCart() {
        cartContainer.innerHTML = '';
        if (state.selectedItems.length === 0) {
          cartContainer.innerHTML = `
            <div class="py-4 text-center text-outline font-body-sm text-body-sm">
              No documents selected yet.<br>Click any document to add.
            </div>
          `;
          return;
        }

        state.selectedItems.forEach(item => {
          const itemEl = document.createElement('div');
          itemEl.className = 'cart-item bg-surface-container-low p-space-sm rounded-xl flex items-center justify-between gap-space-xs';
          itemEl.dataset.itemId = item.id;
          itemEl.innerHTML = `
            <div class="flex flex-col min-w-0">
              <span class="font-headline-sm text-body-sm text-on-surface font-semibold truncate">${item.name}</span>
              <span class="font-code-sm text-code-sm text-outline">${item.copies} Copy • ₱${item.price.toFixed(2)}</span>
            </div>
            <div class="flex items-center gap-2 flex-shrink-0">
              <span class="font-headline-sm text-body-sm text-primary font-bold">₱${(item.price * item.copies).toFixed(2)}</span>
              <button type="button" class="remove-btn text-on-surface-variant hover:text-error p-1 rounded-lg transition-colors" data-id="${item.id}" title="Remove">
                <span class="material-symbols-outlined text-[18px]">close</span>
              </button>
            </div>
          `;
          cartContainer.appendChild(itemEl);
        });

        // Bind remove buttons
        cartContainer.querySelectorAll('.remove-btn').forEach(btn => {
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            const id = btn.dataset.id;
            removeItem(id);
          });
        });
      }

      function updateCardVisuals() {
        const cards = document.querySelectorAll('.doc-card');
        cards.forEach(card => {
          const id = card.dataset.id;
          const isSelected = state.selectedItems.some(i => i.id === id);
          const actionSlot = card.querySelector('.action-slot');

          if (isSelected) {
            card.classList.add('ring-2', 'ring-primary-container', 'shadow-md');
            if (actionSlot) {
              actionSlot.innerHTML = `
                <span class="flex items-center gap-1 px-space-sm py-1 rounded-lg bg-primary-container text-on-primary font-label-sm text-label-sm">
                  <span class="material-symbols-outlined text-[16px]">check_circle</span>
                  <span>SELECTED</span>
                </span>
              `;
            }
          } else {
            card.classList.remove('ring-2', 'ring-primary-container', 'shadow-md');
            if (actionSlot) {
              actionSlot.innerHTML = `
                <button type="button" class="btn-select flex items-center gap-1 px-space-sm py-1 rounded-lg bg-surface-container-high hover:bg-primary hover:text-on-primary text-on-surface font-label-sm text-label-sm transition-colors">
                  <span class="material-symbols-outlined text-[16px]">add</span>
                  <span>REQUEST NOW</span>
                </button>
              `;
            }
          }
        });
      }

      function toggleItem(id, name, price) {
        const existingIdx = state.selectedItems.findIndex(i => i.id === id);
        if (existingIdx > -1) {
          state.selectedItems.splice(existingIdx, 1);
        } else {
          state.selectedItems.push({ id, name, price: parseFloat(price), copies: 1 });
        }
        calculateTotals();
        updateCardVisuals();
      }

      function removeItem(id) {
        state.selectedItems = state.selectedItems.filter(i => i.id !== id);
        calculateTotals();
        updateCardVisuals();
      }

      // Add click listeners to cards
      document.querySelectorAll('.doc-card').forEach(card => {
        card.addEventListener('click', () => {
          const id = card.dataset.id;
          const name = card.dataset.name;
          const price = card.dataset.price;
          toggleItem(id, name, price);
        });
      });

      // Clear all
      clearCartBtn.addEventListener('click', () => {
        state.selectedItems = [];
        calculateTotals();
        updateCardVisuals();
      });

      // Fulfillment Toggle
      const methodPickup = document.getElementById('methodPickup');
      const methodDelivery = document.getElementById('methodDelivery');

      methodPickup.addEventListener('click', () => {
        state.fulfillment = 'pickup';
        methodPickup.className = 'fulfillment-btn active-method py-2 px-space-sm rounded-lg font-label-md text-label-md transition-all flex items-center justify-center gap-1.5 bg-primary-container text-on-primary font-bold shadow-sm';
        methodDelivery.className = 'fulfillment-btn py-2 px-space-sm rounded-lg font-label-md text-label-md transition-all flex items-center justify-center gap-1.5 text-on-surface-variant hover:text-on-surface';
        fulfillmentFeeLabel.textContent = 'Pick-up Logistics';
        pickupLocationNote.textContent = 'Location: Window 3, University Registrar, Obrero Main Campus';
        calculateTotals();
      });

      methodDelivery.addEventListener('click', () => {
        state.fulfillment = 'delivery';
        methodDelivery.className = 'fulfillment-btn active-method py-2 px-space-sm rounded-lg font-label-md text-label-md transition-all flex items-center justify-center gap-1.5 bg-primary-container text-on-primary font-bold shadow-sm';
        methodPickup.className = 'fulfillment-btn py-2 px-space-sm rounded-lg font-label-md text-label-md transition-all flex items-center justify-center gap-1.5 text-on-surface-variant hover:text-on-surface';
        fulfillmentFeeLabel.textContent = 'LBC Standard Courier';
        pickupLocationNote.textContent = 'Standard Door-to-Door Delivery (3-5 days after document generation)';
        calculateTotals();
      });

      // Payment toggles
      const payButtons = document.querySelectorAll('.pay-btn');
      payButtons.forEach(btn => {
        btn.addEventListener('click', () => {
          payButtons.forEach(b => {
            b.className = 'pay-btn flex items-center justify-center gap-2 p-2 rounded-xl bg-surface-container-low text-on-surface hover:bg-surface-container-high text-label-md font-semibold transition-all';
          });
          btn.className = 'pay-btn active-pay flex items-center justify-center gap-2 p-2 rounded-xl bg-primary-container text-on-primary text-label-md font-bold transition-all shadow-sm';
        });
      });

      // Category filter buttons
      const filterBtns = document.querySelectorAll('.filter-btn');
      filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
          filterBtns.forEach(b => {
            b.className = 'filter-btn px-space-md py-space-xs rounded-lg font-label-md text-label-md transition-all text-on-surface-variant hover:bg-surface-container-high whitespace-nowrap';
          });
          btn.className = 'filter-btn active-filter px-space-md py-space-xs rounded-lg font-label-md text-label-md transition-all bg-primary-container text-on-primary font-bold shadow-sm whitespace-nowrap';

          const filter = btn.dataset.filter;
          document.querySelectorAll('.doc-card').forEach(card => {
            if (filter === 'all' || card.dataset.category === filter) {
              card.classList.remove('hidden');
            } else {
              card.classList.add('hidden');
            }
          });
        });
      });

      // Keyword search
      const searchInput = document.getElementById('searchInput');
      searchInput.addEventListener('input', (e) => {
        const query = e.target.value.toLowerCase().trim();
        document.querySelectorAll('.doc-card').forEach(card => {
          const name = (card.dataset.name || '').toLowerCase();
          const category = (card.dataset.category || '').toLowerCase();
          if (name.includes(query) || category.includes(query)) {
            card.classList.remove('hidden');
          } else {
            card.classList.add('hidden');
          }
        });
      });

      // Submission to API
      document.getElementById('btnSubmitOrder').addEventListener('click', async () => {
        if (state.selectedItems.length === 0) {
          alert('Please select at least one document before submitting.');
          return;
        }
        const total = grandTotalText.textContent;
        const userStr = window.localStorage.getItem('currentUser');
        if (!userStr) {
          alert('Please log in again to submit requests.');
          return;
        }
        
        const user = JSON.parse(userStr);
        const btn = document.getElementById('btnSubmitOrder');
        const originalText = btn.innerHTML;
        btn.innerHTML = '<span class="material-symbols-outlined animate-spin text-[20px]">refresh</span> Processing...';
        btn.disabled = true;

        // Determine active payment method from DOM
        let paymentMethod = 'cash';
        document.querySelectorAll('.pay-btn').forEach(b => {
          if (b.classList.contains('active-pay')) {
            if (b.innerText.toLowerCase().includes('cashier')) paymentMethod = 'cashier';
            if (b.innerText.toLowerCase().includes('online')) paymentMethod = 'online';
          }
        });

        try {
          const response = await fetch('api/submit_request.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              student_id: user.id,
              fulfillment_method: state.fulfillment,
              payment_method: paymentMethod,
              items: state.selectedItems.map(i => i.id)
            })
          });
          
          const result = await response.json();
          if (result.success) {
            alert('Request submitted successfully! Tracking Code: ' + result.tracking_code);
            // Clear cart
            state.selectedItems = [];
            calculateTotals();
            updateCardVisuals();
            window.location.href = 'request-tracker.html';
          } else {
            alert(result.message || 'Error submitting request.');
          }
        } catch (err) {
          console.error(err);
          alert('A network error occurred.');
        } finally {
          btn.innerHTML = originalText;
          btn.disabled = false;
        }
        alert(`Order confirmed for ${state.selectedItems.length} document(s). Total: ${total}. Redirecting to secure gateway...`);
      });

      // Initial state render
      calculateTotals();
      updateCardVisuals();
    })();
  