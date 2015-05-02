var modal = function() {
  $('#myModal').on('shown.bs.modal', function() {
    alert('shown triggered');
  });

};

$(document).ready(modal);
