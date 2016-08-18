module Hancock::Feedback
  module Admin
    module ContactMessage
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('hancock.feedback')
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
