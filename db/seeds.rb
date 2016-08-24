# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'

titleUrlObj = []

mangalist = Nokogiri::HTML(open("http://www.mangahere.co/mangalist/"))

mangalist.css("div.list_manga ul li a").each do | mangaList |
	titleUrlObj.push({name: mangaList.content, url: mangaList['href']})
end

titleUrlObj.each do | singleMO |
	
	mangaPageRequest = Nokogiri::HTML(open(singleMO[:url]))

	lastChapterScopingRequest = mangaPageRequest.css("div.detail_list ul li span.left a").first
	lastChapterPostDateRequest = mangaPageRequest.css("div.detail_list ul li span.right").first

	if lastChapterScopingRequest
		total = 0 
		theLastChapter = lastChapterScopingRequest.content.split(" ").pop
		thePostedDate = lastChapterPostDateRequest.content

		mangaPageRequest.css("div.detail_list ul li a").each do | chapter_link |
			total += 1
		end	

		Manga.create(
			title: singleMO[:name],
			link_to_page: singleMO[:url],
			total_chapters: total,
			last_chapter: theLastChapter,
			posted_date: thePostedDate
		)

	else 
		Manga.create(
			title: singleMO[:name],
			link_to_page: singleMO[:url],
			total_chapters: 0,
			last_chapter: 0,
			posted_date: "none"
		)
	end	
end

# linksArray

# 	mangaLink = mangaList['href']
	
# 	mangaPageRequest = Nokogiri::HTML(open(mangaLink))


# 	lastChapterScopingRequest = mangaPageRequest.css("div.detail_list ul li span.left a").first
# 	lastChapterPostDateRequest = mangaPageRequest.css("div.detail_list ul li span.right").first

# 	if lastChapterScopingRequest
# 		total = 0 

# 		mangaPageRequest.css("div.detail_list ul li a").each do | chapter_link |
# 			total += 1
# 		end	

# 		Manga.create(
# 			title: mangaList.content,
# 			link_to_page: mangaLink,
# 			total_chapters: total.length,
# 			last_chapter: lastChapterScopingRequest.content.split(" ").pop,
# 			posted_date: lastChapterPostDateRequest.content
# 		)

# 	else 
# 		Manga.create(
# 			title: mangaList.content,
# 			link_to_page: mangaLink,
# 			total_chapters: 0,
# 			last_chapter: 0,
# 			posted_date: "none"
# 		)
# 	end	
# end




# # def calculateTotalChapters(aMangaPage)
# # 	total = []
# # 	doc.css("div.detail_list ul li a").each do | link |
# # 		total.push(link)
# # 	end	
# # 	return total.length
# # end