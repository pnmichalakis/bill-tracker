class ApplicationController < Sinatra::Base
	ActiveRecord::Base.establish_connection({
		adapter: 'postgresql',
		database: 'congressional_database'
	})

	set :views, File.expand_path('../../views',__FILE__)
	set :public_folder, File.expand_path('../../public',__FILE__)

	enable :method_override
	use Rack::Session::Pool

	after { ActiveRecord::Base.connection.close }

	get '/' do
		@bills = HTTParty.get('https://www.govtrack.us/api/v2/bill?congress=114')
		@bill_link = @bills["objects"].first["link"]
		@congress = HTTParty.get('https://www.govtrack.us/api/v2/person')
		@congress_names = @congress.map do |person|
												person["sortname"]
											end
		erb :index
	end

end