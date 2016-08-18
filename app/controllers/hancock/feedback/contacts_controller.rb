module Hancock::Feedback
  class ContactsController < ApplicationController
    include Hancock::Feedback::Controllers::Contacts

    include Hancock::Feedback::Decorators::Contacts
  end
end
