unless defined?(Hancock) && Hancock.respond_to?(:orm) && [:active_record, :mongoid].include?(Hancock.orm)
  puts "please use hancock_cms_mongoid or hancock_cms_activerecord"
  puts "also: please use hancock_cms_news_mongoid or hancock_cms_news_activerecord and not hancock_cms_news directly"
  exit 1
end

require "hancock/feedback/version"

require 'hancock/feedback/configuration'
require 'hancock/feedback/engine'
require 'hancock/feedback/routes'

require 'addressable/uri'
require 'validates_email_format_of'
require 'x-real-ip'

module Hancock::Feedback
  # Hancock::register_plugin(self)

  class << self
    def orm
      Hancock.orm
    end
    def mongoid?
      Hancock::Feedback.orm == :mongoid
    end
    def active_record?
      Hancock::Feedback.orm == :active_record
    end
    def model_namespace
      "Hancock::Feedback::Models::#{Hancock::Feedback.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

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
