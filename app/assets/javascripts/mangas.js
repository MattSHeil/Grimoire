$(document).ready(function(){
	$(".ajaxit").on("click", function(event){
		var searchTerm = $(event.currentTarget).data("genre")
		$.ajax({
			type: "GET",
			url: `/mangas/search/${searchTerm}`,
			success: genreHandler,
			error: errorHandler
		});
	});

	function genreHandler(response){
		console.log(response)


		$('.todostuff-js').addClass("main")
		// $('.todostuff-js').addId("content")

		response.forEach(function(mangaCollection){
			// console.log(mangaCollection.title)
			var toAppend = `<li><button class="toFrame button" data-link="${mangaCollection.link_to_page}">${mangaCollection.title}</button></li>`
			$('.SearchedMangas').append(toAppend);

			});

	};

	function errorHandler(response){
		console.log(response)
	};

	$(".toFrame").on('click',function(event){

		$(event.currentTarget).append()

	});

	$(".add-btn").on('click', function(event){
		event.preventDefault();

		var idToBeAdded = $('.add-btn').data('id');

		$.ajax({
			type: "POST",
			url: `/mangas/${idToBeAdded}/add`,
			success: addMangaSuccess,
			error: addMangaError
		});
	});

	function addMangaSuccess(response){
		console.log("I adds")
		$(".add-btn").toggleClass("hide")
		$(".delete-btn").toggleClass("hide")
	};

	function addMangaError(response){
		console.log("I dont adds")
	};

	$(".delete-btn").on('click', function(event){
		event.preventDefault();

		var idToBeAdded = $('.delete-btn').data('id');

		$.ajax({
			type: "DELETE",
			url: `/mangas/${idToBeAdded}/delete`,
			success: deleteMangaSuccess,
			error: deleteMangaError
		});
	});

	function deleteMangaSuccess(response){
		console.log("I deletes")
		$(".delete-btn").toggleClass("hide")
		$(".add-btn").toggleClass("hide")
	};

	function deleteMangaError(response){
		console.log("I dont deletes")
	};
})