var ready = function() {

    function addRow(event) {

	if ($(".invoice-delete-entry").length > 0) $(".invoice-delete-entry").show();

	event.preventDefault();
	event.stopPropagation();

	var lastentry = $('.invoice-item-row').last();
	var newentry = $(lastentry).clone(true, true);
	var formsonpage = $('.invoice-item-row').length;

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

	$(newentry).insertAfter(lastentry);
    }

    function removeEntry( event ) {
	$(this).parents('.invoice-item-row').remove();
	if ($(".invoice-delete-entry").length < 2) $(".invoice-delete-entry").hide();
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
	$('#invoice-total').val(sum);
    }

    $('#invoice-addrow').click(addRow);
    $('.fee').keyup(updateTotal);
    $( ".invoice-delete-entry" ).click(removeEntry);
    $(".invoice-delete-entry").hide();
};

document.addEventListener("turbolinks:load", function() {
    ready();
});
