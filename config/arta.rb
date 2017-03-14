# encoding: utf-8
# ## Scope
#   A module wich includes four {http://www.sinatrarb.com/ Sinatra::Base} sub classes
#   {Arta::Public}, {Arta::System}, {Arta::Assets}  and {Arta::Utils}
#   ...
# @todo document this model
module Arta
  @@opt = OpenStruct.new
  class << self
    # @todo
    def opt
      @@opt
    end
    # @todo
    def opt=(v)
      @@opt = v
    end
    # @todo
    def root
      opt.root || ARTA_ROOT
    end
    # @todo
    def env
      opt.env || ARTA_ENV
    end
    # @todo
    def views
      opt.views || File.join(ARTA_ROOT,'system','views')
    end
    # @todo
    def assets
      opt.assets || File.join(ARTA_ROOT,'system','assets')
    end
    # @todo
    def models
      opt.models || File.join(ARTA_ROOT,'system','models')
    end
    # @todo
    def firm
      file = YAML.load_file File.join(ARTA_ROOT,'config','firm.yml')
      OpenStruct.new file['firm']
    end
  end
  # @todo document this method
  def self.server
    Rack::Builder.new do
      use Rack::Session::Cookie,
        expire_after: 12*60*60,
        secret: '15753454a2e77700a28a2d0aa8bebee57c42452713d115232b9abafc5dae9a12'
      use Rack::Rewrite do
        rewrite %r{^/\w{2}/utils},      '/utils'
        rewrite %r{^/\w{2}/sys},        '/sys'
        rewrite %r{^/\w{2}/(.*)},       '/$1'
      end

      map '/utils' do
        run Utils
      end
      map '/sys' do
        run System
      end
      map '/' do
        run Public
      end
    end
  end
  autoload :System,               'system'
  autoload :Public,               Arta.firm.public['controller']
  autoload :Utils,                'utils'
  autoload :Assets,               'assets'
  firm.models_path.each do |mp|
    Dir.glob(File.join(models,mp,'*.rb')).each do |m|
      require m
    end
  end
end
