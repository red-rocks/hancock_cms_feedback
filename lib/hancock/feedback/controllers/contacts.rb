module Hancock::Feedback
  module Controllers
    module Contacts
      extend ActiveSupport::Concern

      included do
        if Hancock::Feedback.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('hancock.breadcrumbs.contacts'), :hancock_feedback_contacts_path
        end

        helper_method :is_cache_fields, :cache_key, :fields_partial, :settings_scope, :hancock_feedback_update_captcha_path
      end

      def index
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def new
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def create
        @contact_message = model.new(message_params)
        after_initialize

        if Hancock::Feedback.config.captcha
          if Hancock::Feedback.config.recaptcha_support
            if verify_recaptcha
              meth = :save
            else
              meth = :valid?
              @recaptcha_error = I18n.t('hancock.errors.feedback.recaptcha')
            end

          elsif Hancock::Feedback.config.simple_captcha_support
            meth = :save_with_captcha

          else
            meth = :save
          end
        else
          meth = :save
        end

        if @contact_message.send(meth) and @recaptcha_error.blank?
          after_create
          if request.xhr? && process_ajax
            ajax_success
          else
            redirect_after_done
          end
        else
          render_contacts_error
        end
      end

      def sent
      end

      def update_captcha
        render layout: false
      end


      def hancock_feedback_update_captcha_path
        url_for(action: :update_captcha, time: Time.new.to_i, only_path: true)
      end
      def is_cache_fields
        cache_fields?
      end
      def cache_fields?
        ['new', 'index'].include? action_name
      end
      def cache_key
        'hancock_feedback_contacts_fields'.freeze
      end
      def fields_partial
        "hancock/feedback/contacts/#{(Hancock::Feedback.config.model_settings_support ? 'fields_with_settings' : 'fields')}".freeze
      end
      def settings_scope
        if Hancock::Feedback.config.model_settings_support
          model.settings
        elsif defined?(Settings)
          Settings.ns('feedback')
        else
          nil
        end
      end


      private
      def render_contacts_error
        if request.xhr? && process_ajax
          render partial: form_partial, status: 422
          # render json: {errors: @contact_message.errors}, status: 422
        else
          flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
          render action: Hancock::Feedback.configuration.recreate_contact_message_action, status: 422
        end
      end
      def process_ajax
        true
      end
      def ajax_success
        render partial: success_partial
        # render json: {ok: true}
      end
      def redirect_after_done
        redirect_to action: :sent
      end
      def xhr_checker
        if request.xhr?
          render layout: false
        end
      end
      def after_initialize
      end
      def after_create
        # overrideable hook for updating message
      end
      def form_partial
        "hancock/feedback/contacts/form"
      end
      def success_partial
        "hancock/feedback/contacts/success"
      end
      def model
        Hancock::Feedback::ContactMessage
      end
      def message_params
        params.require(model.to_param.gsub("::", "").underscore).permit(
          Hancock::Feedback::ContactMessage.permitted_fields + [:name, :email, :phone, :content, :captcha, :captcha_key]
        )
      end

    end
  end
end
