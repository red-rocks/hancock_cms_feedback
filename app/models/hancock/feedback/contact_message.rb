module Hancock::Feedback
  if Hancock::Feedback.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage

    include Hancock::Feedback::Models::ContactMessage

    include Hancock::Feedback::Decorators::ContactMessage

    rails_admin(&Hancock::Feedback::Admin::ContactMessage.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
