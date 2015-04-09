var ready = function() {
  function addEntry() {
    var lastentry = $('.entry').last();
    var newentry = $(lastentry).clone(true, true);
    var formsonpage = $('.entry').length;

    $(newentry).find('input').each(function(input) {
      var oldid = $(this).attr('id');
      var oldname = $(this).attr('name');

      var id = '_' + formsonpage + '_';
      var newid = oldid.replace(new RegExp(/_\d+_/), id);

      var name = '[' + formsonpage + ']';
      var newname = oldname.replace(new RegExp(/\[\d+\]/), name);

      $(this).attr('id', newid);
      $(this).attr('name', newname);
      $(this).val('');
    });

    //entry.find('#addentry').hide();
    $(lastentry).find('a').text('Remove entry');
    $(lastentry).find('a').removeClass('addentry')
      .addClass('removeentry')
      .off('click')
      .click(removeEntry);

    $(newentry).insertAfter(lastentry);
  }

  function removeEntry() {
    $(this).closest('.entry').slideUp().remove();
  }

  function updateTotal() {
    var idsum = document.getElementById("sum");
    var fees = document.getElementsByClassName("fees");

    var sum = 0;
    for (var i=0; i < fees.length; i++) {
        var fee = parseFloat(fees[i].value);
        if(isNaN(fee)){
            continue;
        }
        sum += fee;
    }
    idsum.value = sum;
  }

  $('.addentry').click(addEntry);
  $('#fee').keyup(updateTotal);
};

$(document).ready(ready);
$(document).on('page:load', ready);
