# encoding: utf-8
module Arta
  module Helpers
    class << self
      def registered(app)
        app.helpers self
      end
    end
    # @todo document this method
    def pdf(*args)
      render(:rb, *args)
    end
    # Delegates to I18n.translate with no additional functionality.
    #
    # @param [Symbol] *args
    #   The keys to retrieve.
    #
    # @return [String]
    #  The translation for the specified keys.
    #
    # @api public
    def translate(*args)
      args[0] = "#{Arta.firm.i18n_path}.#{args[0]}"
      I18n.translate(*args)
    end
    alias :t :translate
    # Delegates to I18n.localize with no additional functionality.
    #
    # @param [Symbol] *args
    #   The keys to retrieve.
    #
    # @return [String]
    #  The translation for the specified keys.
    #
    # @api public
    def localize(*args)
      I18n.localize(*args)
    end
    alias :l :localize
    ##
    # Translates attribute name for the given model.
    #
    # @param [Symbol] model
    #  The model name for the translation.
    # @param [Symbol] attribute
    #  The attribute name in the model to translate.
    #
    # @return [String] The translated attribute name for the current locale.
    #
    # @example
    #   # => t("models.account.attributes.email", :default => "Email")
    #   mat(:account, :email)
    #
    def model_attribute_translate(model, attribute)
      model = model.is_a?(Mongoid::Document) ? model.class : model
      model.human_attribute_name(attribute)
    end
    alias :mat :model_attribute_translate
    # @todo
    def model_name
      mat(@object, 'model_name')
    end
    # Set language prefix for browser's path
    # @return [String]
    def localized_path
      lang = I18n.locale.to_s
      lang == "ro" ? "" : "/#{lang}"
    end
    alias :lp :localized_path
    # @todo
    def body_data
        @body_data
    end
    # @todo
    def active_class(slug)
      slug == @body_data[:slug] ? {:class => "active"} : {}
    end
 end # Helper
end # Arta
