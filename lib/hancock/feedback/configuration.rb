module Hancock::Feedback
  include Hancock::PluginConfiguration

  def self.config_class
    Configuration
  end

  class Configuration
    attr_accessor :captcha
    attr_accessor :message_required

    attr_accessor :seo_support
    attr_accessor :cache_support

    attr_accessor :captcha_error_message
    attr_accessor :no_contact_info_error_message

    attr_accessor :recreate_contact_message_action

    attr_accessor :breadcrumbs_on_rails_support

    attr_accessor :recaptcha_support
    attr_accessor :simple_captcha_support

    attr_accessor :model_settings_support
    attr_accessor :user_abilities_support
    attr_accessor :ra_comments_support

    attr_accessor :personal_data_processing_as_hidden

    def initialize
      @recaptcha_support = !!defined?(Recaptcha)
      @simple_captcha_support = !!defined?(SimpleCaptcha)

      @captcha = @recaptcha_support || @simple_captcha_support
      @message_required = true

      @seo_support    = !!defined? Hancock::Seo
      @cache_support  = !!defined?(Hancock::Cache)

      @captcha_error_message = "Код проверки введен неверно"
      @no_contact_info_error_message = "Пожалуйста введите Ваш e-mail или телефон, чтобы мы могли связаться с вами."

      @recreate_contact_message_action = "new"

      @breadcrumbs_on_rails_support = !!defined?(BreadcrumbsOnRails)

      @model_settings_support = !!defined?(RailsAdminModelSettings)
      @user_abilities_support = !!defined?(RailsAdminUserAbilities)
      @ra_comments_support = !!defined?(RailsAdminComments)

      @personal_data_processing_as_hidden = false
    end
  end
end
