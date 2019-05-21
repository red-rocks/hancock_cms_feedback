module Hancock::Feedback
  class Engine < ::Rails::Engine
    # isolate_namespace Hancock::Feedback

    # rake_tasks do
    #   require File.expand_path('../tasks', __FILE__)
    # end

    # initializer "hancock_cms_feedback.email_defaults" do
    #   # Write default email settings to DB so they can be changed.
    #
    #   #temp
    #   begin
    #     if Settings and Settings.table_exists?
    #       Settings.default_email_from(default: 'noreply@redrocks.pro')
    #       Settings.form_email(default: 'admin@redrocks.pro')
    #       Settings.email_topic(default: 'с сайта')
    #     end
    #   rescue
    #   end
    # end

    ## TEMP
    config.after_initialize do
      # Write default email settings to DB so they can be changed.
      begin
        if Settings and Settings.table_exists?
          settings_scope = if Hancock::Feedback.config.model_settings_support
            Hancock::Feedback::ContactMessage.settings
          else
            Settings.ns('feedback')
          end
          ns = settings_scope.ns.name

          settings_scope.default_email_from(default: 'noreply@site.domain') unless RailsAdminSettings::Setting.ns(ns).where(key: "default_email_from").exists?
          settings_scope.form_email(default: 'admin@site.domain') unless RailsAdminSettings::Setting.ns(ns).where(key: "form_email").exists?
          settings_scope.email_topic(default: 'с сайта') unless RailsAdminSettings::Setting.ns(ns).where(key: "email_topic").exists?
        end
      rescue
      end
    end

  end
end
