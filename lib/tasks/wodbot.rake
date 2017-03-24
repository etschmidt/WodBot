task :post => :environment do
	require 'twitter'

	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["CONSUMER_KEY"]
	  config.consumer_secret     = ENV["CONSUMER_SECRET"]
	  config.access_token        = ENV["ACCESS_TOKEN"]
	  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
	end

	wod = Wod.new
	client.update(wod.print_ss + "\n#fitness #workouts https://GymBull.com\n")
	client.update(wod.print_wod + "\n#fitness #workouts https://GymBull.com\n")
end