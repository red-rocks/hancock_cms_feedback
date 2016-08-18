module Hancock::Feedback
  module Models
    module ContactMessage
      extend ActiveSupport::Concern
      include Hancock::Model

      include Hancock::Feedback.orm_specific('ContactMessage')

      included do
        if Hancock::Feedback.config.simple_captcha_support
          include SimpleCaptcha::ModelHelpers
          apply_simple_captcha message: Hancock::Feedback.configuration.captcha_error_message
        end

        validates_email_format_of :email, unless: 'email.blank?'
        if Hancock::Feedback.config.message_required
          validates_presence_of :content
        end
        validate do
          if email.blank? && phone.blank?
            errors.add(:email, Hancock::Feedback.configuration.no_contact_info_error_message)
          end
        end

        after_create do
          mailer_class.send(mailer_method, self).deliver_now if send_emails?
        end
      end

      def send_emails?
        true
      end

      def mailer_class
        Hancock::Feedback::ContactMailer
      end

      def mailer_method
        :new_message_email
      end

      def permitted_fields
        []
      end

      def self.manager_default_actions
        [:read]
      end
    end
  end
end
