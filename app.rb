require_relative 'models/listing'
#require 'action_view'

class App < Sinatra::Base

  configure do
    set :assets_precompile, %w(application.js application.css *.png *.jpq *.svg *.ttf *.woff)
	set :assets_css_compressor, :sass
	set :assets_js_compressor, :uglifier
	register Sinatra::AssetPipeline
	
	if defined?(RailsAssets)
	  RailsAssets::load_paths.each do |path|
	    settings.sprockets.append_path(path)
      end
	end
  end
  
  get '/' do
    haml :index
  end
  
  get '/tf_idf_values' do
    content_type :json
    relevant_url_portion = params['link'].split('/r/')[1].split('/')
    Listing.get_tf_idf_values(relevant_url_portion[0], relevant_url_portion[2]).to_json
  end    
end