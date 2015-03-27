$(document).ready(function () {
  "use strict";

  function addEntry() {
    // var entries   = document.getElementsByClassName("entry");
    // var newentry  = entries[0].cloneNode(true);
    // var lastentry = entries[entries.length - 1];

    // if(entries.length > 10) {
    //   alert('The maximum number of entries is 10');
    //   return;
    // }

    // lastentry.getElementsByClassName('btn')[0].style.display = 'none';
    // newentry.getElementsByClassName('btn')[0].style.display = 'inline';

    // lastentry.parentNode.insertBefore(cleanEntry(newentry), lastentry.nextSibling);

    var entry = $($('.entry').last());
    var newentry = entry.clone(true, true);

    entry.find('#addentry').hide();
    newentry.find('#fee').val('');
    newentry.find('#text').val('');

    newentry.appendTo('#entries');
  }

  function cleanEntry(entry) {
    var fees = entry.getElementsByClassName("fees");
    fees[0].value = '';

    return entry;;
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

  function retrieveAbbrevations() {
    var xhr = new XMLHttpRequest();

    xhr.open("GET","abbrevations.json");
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        var obj = JSON.parse(xhr.responseText);
        //alert(obj[0]);
      }
    };
    xhr.send(null);
  }

  $('#addentry').click(addEntry);
  $('#fee').keyup(updateTotal);

});
