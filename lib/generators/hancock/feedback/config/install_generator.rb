require 'rails/generators'

module Hancock::Feedback
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::Feedback Config generator'
    def config
      template 'hancock_feedback.erb', "config/initializers/hancock_feedback.rb"
    end

  end
end
