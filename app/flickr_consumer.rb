require_relative 'flickr_service'
require "sinatra/json"

module AppHelpers
  def the_user_name
    "vijay"
  end
end

class MySinatraApp < Sinatra::Base
  helpers Sinatra::JSON
  helpers AppHelpers
  
	get "/show" do
		"Hello Bundler"
		list = FlickrService.new.get_photos
		json(list)
    # haml :show
	end
	
	get '/' do
	  haml :index
	end
end


