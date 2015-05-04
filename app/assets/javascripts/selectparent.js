var renderParent = function() {
  var html = '<div id="parent-info"><hr/>';

  var renderer = function(data) {
    html += 'Parent: ';
    for(i = 0; i < data.length - 1; i++) {
      html += data[i] + ' ';
    }
    html += '<br/>';
    return html + '</div>';
  };

  return renderer;
};
var parentHtml = renderParent();

var selectedParent = function (e) {
  var tableData = $(this).children('td').map(function() {
    return $(this).text();
  }).get();

  $('#parent-modal').modal('hide');
  $('#parent-info').replaceWith(parentHtml(tableData));
};

var addEvents = function() {
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
