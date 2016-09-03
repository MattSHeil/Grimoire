# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'
# def mangaDbSeed
# 	titleUrlObj = []

# 	mangalist = Nokogiri::HTML(open("http://www.mangahere.co/mangalist/"))

# 	mangalist.css("div.list_manga ul li a").each do | mangaList |
# 		titleUrlObj.push({name: mangaList.content, url: mangaList['href']})
# 	end

# 	titleUrlObj.each do | singleMO |
		
# 		mangaPageRequest = Nokogiri::HTML(open(singleMO[:url]))

# 		lastChapterScopingRequest = mangaPageRequest.css("div.detail_list ul li span.left a").first
# 		lastChapterPostDateRequest = mangaPageRequest.css("div.detail_list ul li span.right").first

# 		if lastChapterScopingRequest
# 			total = 0 
# 			theLastChapter = lastChapterScopingRequest.content.split(" ").pop
# 			thePostedDate = lastChapterPostDateRequest.content

# 			mangaPageRequest.css("div.detail_list ul li a").each do | chapter_link |
# 				total += 1
# 			end	

# 			Manga.create(
# 				title: singleMO[:name],
# 				link_to_page: singleMO[:url],
# 				total_chapters: total,
# 				last_chapter: theLastChapter,
# 				posted_date: thePostedDate
# 			)

# 		else 
# 			Manga.create(
# 				title: singleMO[:name],
# 				link_to_page: singleMO[:url],
# 				total_chapters: 0,
# 				last_chapter: 0,
# 				posted_date: "none"
# 			)
# 		end	
# 	end
# end

# Adds a single manga labels.
# mangaObj = Manga.first
# pageRequest = Nokogiri::HTML(open(mangaObj.link_to_page))
# labelsScoping = pageRequest.css("ul.detail_topText li[4]").first.content
# mostLabels = labelsScoping.split(", ")
# lastLabel = mostLabels.delete_at(0).split(":").pop
# mostLabels.push(lastLabel)

# mostLabels.each do | toAddLabel |
# 	mangaObj.labels.push(Label.find_by(name: toAddLabel))
# end

mangaDb = Manga.where(:id => 5018..17120)
# Seeding for labels
# mangaDb.each do | singleManga |
# 	pageRequest = Nokogiri::HTML(open(singleManga.link_to_page))
# 	labelsScoping = pageRequest.css("ul.detail_topText li[4]").first	
# 	if 	labelsScoping 
# 		mostLabels = labelsScoping.content.split(", ")
# 		lastLabel = mostLabels.delete_at(0).split(":").pop
# 		mostLabels.push(lastLabel)
# 		puts singleManga.id 
# 		mostLabels.each do | toAddLabel |
# 			singleManga.labels.push(Label.find_or_create_by(name: toAddLabel.capitalize))
# 		end
# 	end
# end

mangaDb.each do | singleManga |

	pageRequest = Nokogiri::HTML(open(singleManga.link_to_page))
	authorScoping = pageRequest.css("ul.detail_topText li[5]").first	
	artistScoping = pageRequest.css("ul.detail_topText li[6]").first	
	if 	authorScoping 
		authorName = authorScoping.content.split(":").pop
		authorArray = authorName.split(", ")
		authorArray.each do | singleAuthor |
			singleManga.authors.push(Author.find_or_create_by(name: singleAuthor.capitalize))
		end
		
		artistName = artistScoping.content.split(":").pop
		artistArray = artistName.split(", ")
		artistArray.each do | singleArtist |
			singleManga.artists.push(Artist.find_or_create_by(name: singleArtist.capitalize))
		end
		puts singleManga.id
	end
end




