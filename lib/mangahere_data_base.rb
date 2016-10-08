require 'nokogiri'
require 'open-uri'

class MangahereDataBase
	def initialize
	end

	def titleAndUrl(url)
		titleUrlObj = []
		mangalistRequest = Nokogiri::HTML(open(url))
		mangalistRequest.css("div.list_manga ul li a").each do | mangaList |
			titleUrlObj.push({name: mangaList.content, url: mangaList['href']})
		end
		return titleUrlObj
	end

	def createMangaObjFull(titleUrlHash, chapterRequest, dateRequest)
		total = 0 
		chapterRequest.each do | chapter_link |
			total += 1
		end	

		thePostedDate = dateRequest.content

		Manga.create(
			title: titleUrlHash[:name],
			link_to_page: titleUrlHash[:url],
			total_chapters: total,
			posted_date: thePostedDate
		)

		puts "#{titleUrlHash[:name]} was created"
	end

	def createMangaObj(titleUrlHash)
		Manga.create(
			title: titleUrlHash[:name],
			link_to_page: titleUrlHash[:url],
			total_chapters: 0,
			posted_date: "none"
		)
		puts "Empty"	
	end

	def pageExists?(titleUrlHash, chapterRequest, dateRequest)	
		if Manga.find_by(title: titleUrlHash[:name]) == nil
			if chapterRequest.first.nil?
				createMangaObj(titleUrlHash)
			else
				createMangaObjFull(titleUrlHash, chapterRequest, dateRequest)
			end
		else
			puts "Already Created"
		end
	end

	def singleMangaObj(titleUrlHash)
		mangaPageRequest = Nokogiri::HTML(open(titleUrlHash[:url]))
		
		mangaChapterRequest = mangaPageRequest.css("div.detail_list ul li a")
		lastChapterPostDateRequest = mangaPageRequest.css("div.detail_list ul li span.right").first

		pageExists?(titleUrlHash, mangaChapterRequest, lastChapterPostDateRequest)
	end 

	def getAllMangaObjs(url)	
		counter = 0
		titleAndUrl(url).each do | singleMO |
			counter += 1
			singleMangaObj(singleMO)
			puts counter
		end
	end

	def dbRequest(range)
		# range can be = all || Manga.whatever you need
		if range == "all"
	 		db = Manga.all
	 		return db
	 	else 
	 		db = range
			return db
		end
	end 

	def getAllLabels(rangeL)
		dbRequest(rangeL).each do | singleManga |
			pageRequest = Nokogiri::HTML(open(singleManga.link_to_page))
			labelsScoping = pageRequest.css("ul.detail_topText li[4]").first	
			if 	labelsScoping 
				labels = labelsScoping.content.split(":").pop
				labelsArray = labels.split(", ")
				# puts singleManga.id
				# puts labelsArray
				labelsArray.each do | toAddLabel |
					singleManga.labels.push(Label.find_or_create_by(name: toAddLabel.capitalize))
				end
				puts "Labels added to #{singleManga.title}"
			end
		end
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

	def getAA(range)
		dbRequest(range).each do | singleManga |

			pageRequest = Nokogiri::HTML(open(singleManga.link_to_page))
			authorScoping = pageRequest.css("ul.detail_topText li[5]").first	
			artistScoping = pageRequest.css("ul.detail_topText li[6]").first

			if 	authorScoping 
			
				authorObjc(authorScoping, singleManga)
				artistObjc(artistScoping, singleManga)

				puts "AA created for #{singleManga.title}"
			end
		end
	end

	def getMissingInfo
		db = Manga.all
		mangasWithoutLAA = []
		db.each do | singleManga |
			if singleManga.authors.empty?
				mangasWithoutLAA.push(singleManga)
			end
		end
		getAA(mangasWithoutLAA)
		getAllLabels(mangasWithoutLAA)
	end

	def crossReferenceDb
		count = 0 
		fullObj = []
		doc = Nokogiri::HTML(open("http://www.mangahere.co/mangalist/"))
			doc.css("div.list_manga ul li a", ).each do | link |
			count += 1 
			fullObj.push({name: link.content, url: link['href']})
		end
		puts count

		toCreate = []
		fullObj.each do | singleMangaName |
			if Manga.find_by(title: singleMangaName[:name]).nil?
				toCreate.push(singleMangaName)
			end
		end
		if toCreate.empty?
			puts "db is complete as of #{Time.now}"
		else
			toCreate.each do | mangaObj |
				singleMangaObj(mangaObj)			
			end
		end
	end

	def getImages
		db = Manga.all
		db.each do | singleManga |
			pageRequest = Nokogiri::HTML(open(singleManga.link_to_page))
			imgScope = pageRequest.css("div.manga_detail_top img").first
			if imgScope.nil?
				puts "nothing to do here #{singleManga.title}, #{singleManga.id}"
			else
				MangaImg.create(manga_id: singleManga.id, cover_img_url: imgScope['src'])
				puts singleManga.id
				puts singleManga.title
			end
		end	
	end
end
