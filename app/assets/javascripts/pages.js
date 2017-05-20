
document.addEventListener("turbolinks:load", function(){
	$(".alert").show().delay(2000).fadeOut();
	$("#one-way-radio").change(function(){
		if (this.checked) {
			$("#returning").hide();
			$(".btn_search").attr("disabled", true);
		}
	})
	$("#round-trip-radio").change(function(){
		if (this.checked) {
			$("#returning").show();
			$(".btn_search").attr("disabled", false);
		}
	})
	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd',
	});
})