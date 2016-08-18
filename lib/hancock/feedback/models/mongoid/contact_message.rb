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
        end
      end
    end
  end
end
