require 'mangahere_data_base'
require 'updating_mangahere_db' 
# require 'nokogiri'
# require 'open-uri'

mangaHere = MangaHereDataBase.new
mhUpdate = UpdatingMangahereDb.new

# Creates All Manga objs 
# mangaHere.getAllMangaObjs("http://www.mangahere.co/mangalist/")

# Creates All Labels objs and the relationship to a manga 
# mangaHere.getAllLabels("all")

# Creates All Authors and Artists objs and the relationship to a manga
# mangaHere.getAA("all")

# Goes throgh the lastest Mangas added to Mangahere
# mhUpdate.updateNeeded?

# TO BE RAN EVERY 24 HOURS, changes "todays" and "yesterday" posted_date to the new and correct ones
# mhUpdate.fixTodayAndYesterday

#crossreference db
# mangaHere.crossReferenceDb


#after creating new mangas adds the rest of their respective realtional db
# mangaHere.getMissingInfo