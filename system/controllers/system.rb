# encoding: utf-8
module Arta
  # ##Description
  # ##Scope
  # @todo documentation
  class System < Sinatra::Base
    register Sinatra::Flash
    register Arta::Helpers
    set :views, File.join(Arta.views, 'system')

    if Arta.env == 'development'
      use Assets::Stylesheets
      use Assets::Javascripts
    end
  end
end
