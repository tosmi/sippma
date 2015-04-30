var makeTRLinks = function(e) {
  $("tr[data-link]").click(function() {
    window.location = this.data("link");
  });
};

var addEvent = function() {
  $('#parent-modal').on('shown.bs.modal', makeTRLinks);
};

$(document).ready(function() {
  $('#parent-modal').on('shown.bs.modal', function() {
    alert('here');
  });
});
