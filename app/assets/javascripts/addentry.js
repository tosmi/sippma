$( document ).ready(function() {
  function addEntry() {
    var entry = $($('.entry').last());
    var newentry = entry.clone(true, true);

    entry.find('#addentry').hide();
    newentry.find('#fee').val('');
    newentry.find('#text').val('');

    newentry.appendTo('#entries');
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

  $('#addentry').click(addEntry);
  $('#fee').keyup(updateTotal);
});
