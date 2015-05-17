var parentAlreadyAssigned = function(parentId) {
  var currentParentIds = $('#parent-data-input').val();
  if (currentParentIds === undefined) {
    return false;
  }
  if (currentParentIds.split(',').indexOf(parentId) >= 0) {
    return true;
  }
  return false;
};

var renderParent = function() {
  var html = '<div id="parent-info">';

  var renderer = function(data) {
    html += '';
    for(i = 0; i < data.length - 1; i++) {
      html += data[i] + ' ';
    }
    html += '<button name="button" class="btn btn-sm btn-block" id="remove-parent">Remove</button>';
    html += '<hr/>';
    return html + '</div>';
  };

  return renderer;
};

var renderParentData = function() {
  var html = '<div id="parent-data"><input id="parent-data-input" type="hidden" name="patient[parent_ids]" value="';

  var renderer = function(data) {
    html += data[data.length - 1] + ',';
    return html + '"></div>';
  };

  return renderer;
};

var parentHtml = renderParent();
var parentData = renderParentData();

var selectedParent = function (e) {
  var tableData = $(this).children('td').map(function() {
    return $(this).text();
  }).get();

  $('#parent-modal').modal('hide');

  var parentID	= tableData[tableData.length - 1];
  var formURI	= $("form[class='edit_patient']").attr('action');
  var patientID = formURI.split('/')[2];
  var postURI	= formURI + '/relationships';

  var postData = {
    patient_id: patientID,
    relationship: {
      parent_id: parentID
    }
  };

  $.ajax({
    type: "POST",
    url: postURI,
    data: postData,
    dataType: 'application/json',
    complete: function(data) {
      $("#parent-info").replaceWith(data.responseText);
      alert(data.responseText);
    }
  });

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
