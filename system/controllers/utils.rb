# encoding: utf-8
module Arta
  # ##Description
  # ##Scope
  # @todo documentation
  class Utils < Sinatra::Base
    register Sinatra::Flash
    register Arta::Helpers
    set :views, File.join(Arta.views, 'utils')

    if Arta.env == 'development'
      use Assets::Stylesheets
      use Assets::Javascripts
    end

    # @todo Document this method
    get '/lang/:lang/:file' do |l,f|
      I18n.locale = l.to_sym
      path = "#{lp}/#{f}"
      redirect path
    end
  end
end
