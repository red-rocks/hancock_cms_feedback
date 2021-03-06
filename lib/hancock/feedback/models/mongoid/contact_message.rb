module Hancock::Feedback
  module Models
    module Mongoid
      module ContactMessage
        extend ActiveSupport::Concern
        included do
          field :name, type: String
          field :email, type: String
          field :phone, type: String
          field :content, type: String

          if Hancock.rails5?
            if relations.has_key?("updater") and defined?(::Mongoid::History)
              belongs_to :updater, class_name: ::Mongoid::History.modifier_class_name, optional: true, validate: false
              _validators.delete(:updater)
              _validate_callbacks.each do |callback|
                if callback.raw_filter.respond_to?(:attributes) and callback.raw_filter.attributes.include?(:updater)
                  _validate_callbacks.delete(callback)
                end
              end
            end
          end

          attr_accessor :personal_data_processing

          def personal_data_processing=(string_value)
            @personal_data_processing = (string_value == '1')
          end
          validate do
            unless self.personal_data_processing
              self.errors.add(:personal_data_processing, I18n.t('mongoid.errors.models.hancock/feedback/contact_message.attributes.personal_data_processing.checked_required'))
            end
          end

        end

        class_methods do
          def track_history?
            false
          end
        end

      end
    end
  end
end
