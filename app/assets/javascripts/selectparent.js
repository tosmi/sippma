var selectedParent = function (e) {
  alert('delegate');
};

var addEvents = function() {
  alert('addEvents');

  $('#add-parent').click(function() {
    $('#parent-modal').modal('show');
    return false;
  });

  $('#parent-table').delegate('tr','click', selectedParent);
};

$(document).ready(function() {
  addEvents();
});

$(document).on('page:load', addEvents);
