"use strict";

// var at;
// if (!at) {
//     at = {};
// } else if (typeof org != 'object') {
//     throw new Error('at already exists and is not an object.');
// }

// if(!at.stderr) {
//     at.stderr = {};
// } else if (typeof at.stderr != 'object') {
//     throw new Error('at already exists and is not an object.');
// }

// function addEntry() {
//     var entries   = document.getElementsByClassName("entry");
//     var newentry  = entries[0].cloneNode(true);
//     var lastentry = entries[entries.length - 1];

//     if(entries.length > 10) {
// 	alert('The maximum number of entries is 10');
// 	return;
//     }

//     lastentry.parentNode.insertBefore(cleanEntry(newentry), lastentry.nextSibling);
// }

// function cleanEntry(entry) {
//     var fees = entry.getElementsByClassName("fees");
//     fees[0].value = '';

//     return entry;;
// }

// function updateTotal() {
//     var idsum = document.getElementById("sum");
//     var fees = document.getElementsByClassName("fees");

//     var sum = 0;
//     for (i=0; i < fees.length; i++) {
// 	var fee = parseFloat(fees[i].value);
// 	if(isNaN(fee)){
// 	    continue;
// 	}
// 	sum += fee;
//     }

//     idsum.value = sum;
// }

var xmlhttp = new XMLHttpRequest();

xmlhttp.open("GET","abbrevations.json");

xmlhttp.onreadystatechange = function() {
    alert(xmlhttp.readyState + " " + xmlhttp.status);
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
	alert('readystate 4');
//	var array = JSON.parse(xmlhttp.responseText);
	alert(xmlhttp.responseText);
    }
    else {

	// alert(xmlhttp.getAllResponseHeaders());

    }
};

xmlhttp.send(null);
