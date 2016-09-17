every 1.minutes do 
	
	rake "update_db", 
	output: {
		error: "#{Whenever.path}/log/error_update_db.log", 
		standard: "#{Whenever.path}/log/cron_update_db.log" 
	},
	:environment => 'development'

end

every 1.day, :at => "11:59 pm"  do

	rake "fix_today_yesterday", 
	output: { 
		error: "#{Whenever.path}/log/error_fix_today_yesterday.log", 
		standard: "#{Whenever.path}/log/cron_fix_today_yesterday.log" 
	}, 
	:environment => 'development'

end 

every :sunday do 

	rake "cross_referece_db", 
	output: { 
		error: "#{Whenever.path}/log/error_cross_referece_db.log", 
		standard: "#{Whenever.path}/log/cron_cross_referece_db.log" 
	}, 
	:environment => 'development'

end
