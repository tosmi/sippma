document.addEventListener("turbolinks:load", function() {
    $("td.patient-click[data-link]").click(function() {
	window.location = $(this).data("link");
    });
});
