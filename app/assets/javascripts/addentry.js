$( document ).ready(function() {
  function addEntry() {
    var lastentry = $('.entries').last();
    var newentry = $(lastentry).clone(true, true);
    var formsonpage = $('.entries').length;

    $(newentry).find('input').each(function(input) {
      oldid = $(this).attr('id');
      oldname = $(this).attr('name');
    });

    // entry.find('#addentry').hide();
    // newentry.find('#fee').val('');
    // newentry.find('#text').val('');

    // newentry.appendTo('#entries');
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
});
