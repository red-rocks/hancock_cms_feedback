module Hancock::Feedback::Decorators
  module Contacts
    extend ActiveSupport::Concern

    # included do
    #
    #   def hancock_feedback_update_captcha_path
    #     url_for(action: :update_captcha, time: Time.new.to_i, only_path: true)
    #   end
    #   def is_cache_fields
    #     cache_fields?
    #   end
    #   def cache_fields?
    #     ['new', 'index'].include? action_name
    #   end
    #   def cache_key
    #     'hancock_feedback_contacts_fields'.freeze
    #   end
    #   def fields_partial
    #     "hancock/feedback/contacts/#{(Hancock::Feedback.config.model_settings_support ? 'fields_with_settings' : 'fields')}".freeze
    #   end
    #   def settings_scope
    #     if Hancock::Feedback.config.model_settings_support
    #       model.settings
    #     elsif defined?(Settings)
    #       Settings.ns('feedback')
    #     else
    #       nil
    #     end
    #   end
    #   def recaptcha_options
    #     {}
    #   end
    #
    #
    #   def render_contacts_error
    #     if request.xhr? && process_ajax
    #       render partial: form_partial, status: 422
    #       # render json: {errors: @contact_message.errors}, status: 422
    #     else
    #       flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
    #       render action: Hancock::Feedback.configuration.recreate_contact_message_action, status: 422
    #     end
    #   end
    #   def process_ajax
    #     true
    #   end
    #   def ajax_success
    #     render partial: success_partial
    #     # render json: {ok: true}
    #   end
    #   def redirect_after_done
    #     redirect_to action: :sent
    #   end
    #   def xhr_checker
    #     if request.xhr?
    #       render layout: false
    #     end
    #   end
    #   def after_initialize
    #   end
    #   def after_create
    #     # overrideable hook for updating message
    #   end
    #   def form_partial
    #     "hancock/feedback/contacts/form"
    #   end
    #   def success_partial
    #     "hancock/feedback/contacts/success"
    #   end
    #   def model
    #     Hancock::Feedback::ContactMessage
    #   end
    #   def message_params
    #     params.require(model.to_param.gsub("::", "").underscore).permit(
    #       model.permitted_fields + [:name, :email, :phone, :content, :captcha, :captcha_key]
    #     )
    #   end
    #
    # end


  end
end
