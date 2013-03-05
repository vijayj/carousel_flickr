require 'flickraw'
# require 'yaml'
# FlickRaw.api_key="... Your API key ..."
# FlickRaw.shared_secret="... Your shared secret ..."

class FlickrService
  def initialize
    yaml_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'flickr_keys.yml'))
    
    config = YAML::load_file(yaml_file)

    FlickRaw.api_key=config["key"]
    FlickRaw.shared_secret=config["secret"]    
  end
  
  def debug(list)
    puts "count is #{list}"
    list.each do |l|
      id     = l.id
      secret = l.secret
      info = flickr.photos.getInfo :photo_id => id, :secret => secret
      puts info.title           # => "PICT986"
      puts info.dates.taken     # => "2006-07-06 15:16:18"
      
    end
  end
  
  def get_photos(page_number = 0, page_size = 20)
    list   = flickr.photos.getRecent(:per_page => page_size)
    #debug(list)    
    new_list = list.collect do |l|
      info = flickr.photos.getInfo :photo_id => l.id, :secret => l.secret
      {:title => info.title, :url => FlickRaw.url_b(info)}
    end
    new_list
  end
end