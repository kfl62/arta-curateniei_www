# encoding: utf-8
module Arta
  # ##Description
  # ##Scope
  # @todo documentation
  class Public < Sinatra::Base
    register Sinatra::Flash
    register Arta::Helpers
    set :views, File.join(Arta.views, 'public', Arta.firm.public['views'])

    if Arta.env == 'development'
      use Assets::Stylesheets
      use Assets::Javascripts
    end

    get '/' do
      haml :index
      #send_file File.join(settings.public_folder, 'index.html')
    end

    get '/:page' do |p|
      haml :"#{p}"
    end

  end
end
