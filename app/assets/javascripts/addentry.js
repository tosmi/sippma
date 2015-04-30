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

      if( $(this).hasClass('fee') ) {
	$(this).keyup(updateTotal);
      }
    });

    $(lastentry).find('a').text('Remove entry');
    $(lastentry).find('a').removeClass('addentry')
      .addClass('removeentry')
      .off('click')
      .click(removeEntry);

    $(newentry).insertAfter(lastentry);
  }

  function removeEntry() {
    $(this).closest('.entry').slideUp().remove();
    updateTotal();
  }

  function updateTotal() {
    var sum = 0;
    $('.fee').each(function() {
      var fee = parseFloat($(this).val());
      if(isNaN(fee)) {
    	return;
      }
      sum += fee;
    });
    $('#invoice_totalfee').val(sum);
  }

  $('.addentry').click(addEntry);
  $('.fee').keyup(updateTotal);
};

$(document).ready(ready);
$(document).on('page:load', ready);
