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
})