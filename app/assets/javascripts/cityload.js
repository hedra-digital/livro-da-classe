$(function(){
	$('#form-school-state').on('change', function() {
		$('#form-school-cities').empty();
		var name = $(this).val();
		$.getScript('/get_cities_by_state/' + name);
	});
});