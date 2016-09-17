require 'nokogiri'
require 'open-uri'

class UpdatingMangahereDb
	def initialize
		@savepoint = LastUpdate.last
		@url = 'http://www.mangahere.co/latest/'
	end

	def test 
		puts "Hey I work from the lib folder"
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

	def authorObjc(request, mangaTBA)
		authorNames = request.content.split(":").pop
		authorArray = authorNames.split(", ")
		authorArray.each do | singleAuthor |
			mangaTBA.authors.push(Author.find_or_create_by(name: singleAuthor.capitalize))
		end
	end

	def artistObjc(request, mangaTBA)
		artistName = request.content.split(":").pop
		artistArray = artistName.split(", ")
		artistArray.each do | singleArtist |
			mangaTBA.artists.push(Artist.find_or_create_by(name: singleArtist.capitalize))
		end
	end

	def getAA(mangaObj)
	
		pageRequest = Nokogiri::HTML(open(mangaObj.link_to_page))
		authorScoping = pageRequest.css("ul.detail_topText li[5]").first	
		artistScoping = pageRequest.css("ul.detail_topText li[6]").first

		if 	authorScoping 
		
			authorObjc(authorScoping, mangaObj)
			artistObjc(artistScoping, mangaObj)

			puts "AA created for #{mangaObj.title}"
		end
	end

	def getAllLabels(mangaObj)
		pageRequest = Nokogiri::HTML(open(mangaObj.link_to_page))
		labelsScoping = pageRequest.css("ul.detail_topText li[4]").first	
		if 	labelsScoping 
			labels = labelsScoping.content.split(":").pop
			labelsArray = labels.split(", ")
			# puts singleManga.id
			# puts labelsArray
			labelsArray.each do | toAddLabel |
				mangaObj.labels.push(Label.find_or_create_by(name: toAddLabel.capitalize))
			end
			puts "Labels added to #{singleManga.title}"
		end
	end

	def getExtraInfo(mangaTitle)

		thisManga = Manga.find_by(title: mangaTitle)

		if thisManga.nil?
			puts "Returning nil ..."
			puts "Check #{mangaTitle}"
		else 
			getAA(thisManga)
			getAllLabels(thisManga)
		end

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

				getExtraInfo(toUpdate[:name])
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

		yesterdaysMangas.each do | singleYesterdayManga |	
			updateDates(singleYesterdayManga)
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