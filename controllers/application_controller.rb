class ApplicationController < Sinatra::Base
	ActiveRecord::Base.establish_connection({
		adapter: 'postgresql',
		database: 'congressional_database'
	})

	set :views, File.expand_path('../../views',__FILE__)
	set :public_folder, File.expand_path('../../public',__FILE__)

	# enable :logging, :dump_errors, :raise_errors, :show_exceptions
	enable :method_override
	use Rack::Session::Pool

	after { ActiveRecord::Base.connection.close }

	get '/' do
		erb :index
	end

end