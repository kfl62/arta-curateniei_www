# encoding: utf-8

# Enables support for Compass, a stylesheet authoring framework based on SASS.
# See http://compass-style.org/ for more details.
module CompassInitializer
  def self.registered(app)
    require 'sass/plugin/rack'

    Compass.configuration do |config|
      config.project_path     = Arta.root
      config.sass_dir         = Arta.firm.sass_dir
      config.css_dir          = Arta.firm.css_dir
      config.images_dir       = Arta.firm.images_dir
      config.http_images_path = Arta.firm.images_dir.gsub('public','')
      config.output_style = :compact
      config.sass_options = {cache_location: "./tmp/sass-cache", line_comments: false}
    end

    Compass.configure_sass_plugin!
    Compass.handle_configuration_change!

    app.use Sass::Plugin::Rack
  end
end
