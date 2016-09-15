require 'nokogiri'
require 'open-uri'

class UpdatingMangahereDB
	def initialize
		@savepoint = LastUpdate.last
		@url = 'http://www.mangahere.co/latest/'
	end

	def scrapeLatestPage
		titleUrlObjToUpdate = []
		latestMangas = Nokogiri::HTML(open(@url))
		latestMangas.css("div.manga_updates dl dt a").each do | singleManga |
			titleUrlObjToUpdate.push({name: singleManga.content, link: singleManga['href']})
		end
		# puts titleUrlObjToUpdate
		return titleUrlObjToUpdate
	end

	def updateDB
		arrayToBeUsed = scrapeLatestPage
		checkPoint = arrayToBeUsed[0]
		arrayToBeUsed.each do | toUpdate |
			break if toUpdate[:name] == @savepoint.title
			
			if Manga.find_by(title: toUpdate[:name])
				a = Manga.find_by(title: toUpdate[:name])
				pageRequest = Nokogiri::HTML(open(a.link_to_page))
				mangaChaptersRequest = pageRequest.css("div.detail_list ul li a")
				lastChapterPostDateRequest = pageRequest.css("div.detail_list ul li span.right").first

				newTotal = 0 
				mangaChaptersRequest.each do | chapter_link |
					newTotal += 1
				end	

				newPostedDate = lastChapterPostDateRequest.content

				a.update_attributes(total_chapters: newTotal, posted_date: newPostedDate)
				puts "#{toUpdate[:name]} was updated"
			else
				# byebug
				pageRequest = Nokogiri::HTML(open(toUpdate[:link]))
				mangaChaptersRequest = pageRequest.css("div.detail_list ul li a")
				lastChapterPostDateRequest = pageRequest.css("div.detail_list ul li span.right").first

				total = 0
				mangaChaptersRequest.each do | chapter_link |
					total += 1
				end

				postedDate = lastChapterPostDateRequest.content

				Manga.create(
					title: toUpdate[:name],
					link_to_page: toUpdate[:link],
					total_chapters: total,
					posted_date: postedDate
				)
				puts "NEW MANGA ENTRY: #{toUpdate[:name]}"
			end	
		end
		LastUpdate.create(title: checkPoint[:name], link_to_page: checkPoint[:link])
	end

	def updateDates(mangaObj)
		puts "#{mangaObj.title}, #{mangaObj.posted_date} to ......"
		pageRequest = Nokogiri::HTML(open(mangaObj.link_to_page))
		newPostedDate = pageRequest.css("div.detail_list ul li span.right").first.content
		mangaObj.update_attributes(posted_date: newPostedDate)
		puts "#{newPostedDate}"
		puts ""
	end

	def fixTodayAndYesterday
		todaysMangas = Manga.where(posted_date: "Today")
		yesterdaysMangas = Manga.where(posted_date: "Yesterday")

		todaysMangas.each do | singleTodayManga |
			updateDates(singleTodayManga)
		end

		yesterdaysMangas.each do | singleTodayManga |	
			updateDates(singleTodayManga)
		end
	end

	def updateNeeded?
		latestMangas = Nokogiri::HTML(open(@url))
		lastestUpdate = latestMangas.css("div.manga_updates dl dt a").first
		if lastestUpdate.content == @savepoint.title
			puts "db is up to date"
		else
			updateDB
			puts "Update Completed"
		end
	end
end