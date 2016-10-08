task :update_db => :environment do
	mh = UpdatingMangahereDb.new	
	mh.updateNeeded?
end

task :fix_today_yesterday => :environment do 
	mh = UpdatingMangahereDb.new
	mh.fixTodayAndYesterday
	puts Time.now
end

task :cross_referece_db => :environment do 
	mh = MangahereDataBase.new
	mh.crossReferenceDb	
end

task :get_mangas_extra_info => :environment do
	mh = MangahereDataBase.new
	mh.getMissingInfo
end

task :get_images => :environment do 
	mh = MangahereDataBase.new
	mh.getImages
end	

task :check_images => :environment do 
	mh = UpdatingMangahereDb.new
	mh.checkImgUrls
end

task :new_images => :environment do 
	mh = UpdatingMangahereDb.new
	mh.getNewImg
end