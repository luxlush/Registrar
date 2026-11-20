
  (function() {
    const role = window.localStorage.getItem('currentUserRole');
    if (role !== 'student') {
      window.location.replace('unauthorized.html');
    }
  })();
