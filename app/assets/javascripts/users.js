$(document).ready(function(){
	$('.update_read_js').on('click', function(){
			
		var idToUse = {id: $(this).data('id')};
		console.log(idToUse)
		$.ajax({
			type: 'PUT', 
			url: 'mangas/read',
			data: idToUse,
			success: updateSuccess,  
			error: updateError
		});
	});

	function updateSuccess(response){
		console.log("I UPDATES")
		console.log(response)
	}

	function updateError(error){
		console.log("I dont updates")
		console.log(error)
	}
})