require "hancock/feedback/version"

require 'hancock/feedback/configuration'
require 'hancock/feedback/engine'
require 'hancock/feedback/routes'

require 'addressable/uri'
require 'validates_email_format_of'
require 'x-real-ip'

module Hancock::Feedback
  include Hancock::Plugin

  autoload :Admin,  'hancock/feedback/admin'
  module Admin
    autoload :ContactMessage, 'hancock/feedback/admin/contact_message'
  end

  module Models
    autoload :ContactMessage, 'hancock/feedback/models/contact_message'

    module Mongoid
      autoload :ContactMessage, 'hancock/feedback/models/mongoid/contact_message'
    end
    module ActiveRecord
      autoload :ContactMessage, 'hancock/feedback/models/active_record/contact_message'
    end
  end

  module Controllers
    autoload :Contacts, 'hancock/feedback/controllers/contacts'
  end

end
