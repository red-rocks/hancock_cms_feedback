Hancock.rails_admin_configure do |config|
  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Hancock::Feedback::ContactMessage'
    config.action_visible_for :model_comments, 'Hancock::Feedback::ContactMessage'
  end
end
