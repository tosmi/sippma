var makeTRLinks = function(e) {
  $("tr[data-link]").click(function() {
    window.location = this.data("link");
  });
};

var addEvent = function() {
  alert('addEvent');
  $('#parent-modal').on('shown.bs.modal', makeTRLinks);
};

$(document).ready(function() {
  alert('doc ready');
  $('#parent-modal').on('shown.bs.modal', function() {
    alert('here');
  });
});

$(document).on('page:load', addEvent);
