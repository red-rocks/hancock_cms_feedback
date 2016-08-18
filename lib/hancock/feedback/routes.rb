module ActionDispatch::Routing
  class Mapper

    def hancock_cms_feedback_routes(config = {})
      routes_config = {
        use_contacts_path: true,
        contacts_path: 'contacts',
        classes: {
          contacts: :contacts
        }
      }
      routes_config.deep_merge!(config)

      generate_hancock_feedback_user_routes(routes_config)
      generate_hancock_feedback_cms_routes(routes_config)
    end


    private
    def generate_hancock_feedback_user_routes(routes_config)
      if !routes_config[:use_contacts_path] and !routes_config[:classes][:contacts].nil?
        get   "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#new"
        post  "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#create"
        get   "#{routes_config[:contacts_path]}/sent" => "#{routes_config[:classes][:contacts]}#sent"
      end
    end
    def generate_hancock_feedback_cms_routes(routes_config)
      scope module: 'hancock' do
        scope module: 'feedback' do
          if routes_config[:use_contacts_path]
            get   "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#new",     as: :hancock_feedback_contacts
            post  "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#create",  as: :create_hancock_feedback_contacts
            get   "#{routes_config[:contacts_path]}/sent" => "#{routes_config[:classes][:contacts]}#sent",    as: :hancock_feedback_contacts_sent
          end
        end
      end
    end

  end
end
