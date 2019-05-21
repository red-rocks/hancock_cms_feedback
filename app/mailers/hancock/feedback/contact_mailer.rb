module Hancock::Feedback
  class ContactMailer < ActionMailer::Base
    def new_message_email(message)
      @message = message

      #if message.attachment?
      #  attachments[message.attachment.identifier] = File.read(message.attachment.current_path)
      #end

      # TODO unexepctional
      settings_scope = if Hancock::Feedback.config.model_settings_support
        message.class.settings
      else
        Settings.ns('feedback')
      end

      mail(
          from: settings_scope.default_email_from(default: 'noreply@redrocks.pro'),
          to: settings_scope.form_email(default: 'admin@redrocks.pro'),
          cc: settings_scope.form_email_cc(default: [], kind: :array),
          bcc: settings_scope.form_email_bcc(default: [], kind: :array),
          subject: "[#{settings_scope.email_topic(default: 'с сайта')}] #{message.name} #{message.email}"
      )
    end
  end
end
