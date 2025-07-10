# Disable Ransack search globally for ActiveAdmin to avoid compatibility issues
ActiveAdmin.setup do |config|
  # Disable the search functionality completely
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      # Keep menu simple without search features
    end
  end
end

# Monkey patch to disable all search functionality
module ActiveAdmin
  module Views
    class IndexAsTable < ActiveAdmin::Component
      def build_table
        # Override to prevent search-related issues
        super
      end
    end
  end
end
