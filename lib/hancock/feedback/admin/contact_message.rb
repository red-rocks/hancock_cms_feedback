module Hancock::Feedback
  module Admin
    module ContactMessage
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          nav_label, fields = nav_label[:nav_label], nav_label
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end

        Proc.new {
          navigation_label(!nav_label.blank? ? nav_label : I18n.t('hancock.feedback'))
          
          field :c_at do
            read_only true
          end
          field :name do
            searchable true
          end
          field :content, :text do
            searchable true
          end
          field :email do
            searchable true
          end
          field :phone do
            searchable true
          end

          Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

          if block_given?
            yield self
          end

        }
      end
    end
  end
end
