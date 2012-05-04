module Blog
  class Engine < Rails::Engine
    isolate_namespace Blog

    # Define some initialization parameters and their default values.
    config.blog = ActiveSupport::OrderedOptions.new
    config.blog.layout = 'application'
    config.blog.current_user_method = :current_user
    config.blog.admin_method = :admin?

    config.to_prepare do
      ::ApplicationHelper.class_eval do
        # Returns the current object.  This can be called from a layout or
        # view used with blog to access the containing
        # application's helpers.
        def app_helpers
          self
        end
      end
    end
  end
end
