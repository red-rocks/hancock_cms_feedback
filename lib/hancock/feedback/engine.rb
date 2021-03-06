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

    config.after_initialize do
      # Write default email settings to DB so they can be changed.
      begin
        if Settings and Settings.table_exists?
          Settings.default_email_from(default: 'noreply@site.domain') unless RailsAdminSettings::Setting.ns("main").where(key: "default_email_from").exists?
          Settings.form_email(default: 'admin@site.domain') unless RailsAdminSettings::Setting.ns("main").where(key: "form_email").exists?
          Settings.email_topic(default: 'с сайта') unless RailsAdminSettings::Setting.ns("main").where(key: "email_topic").exists?
        end
      rescue
      end
    end

  end
end
