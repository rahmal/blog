# Configure Blog here.

# The name of the website or blog. Usually used in the title
# or headings on the blog.
Rails.application.config.blog.name = "Blog"

# Retrieve the current user.  This is currently used together with
# blog_admin_method to determine whether the user is an administrator.
#
# Note that this method will be called on controllers that subclass
# Blog::ApplicationController, which means that methods
# defined on your main ApplicationController are _not_ available.  This
# doesn't present any challenges if you're using Devise, or another
# library which defines current_user on ActionController::Base.
#Rails.application.config.blog.current_user_method = :current_user

# Does the current user have administrator privileges?  This will be called
# on the values returned by current_user_method, above.
#Rails.application.config.blog.blog_admin_method = :blog_admin?

# Which application layout should we use to render the blog?
#Rails.application.config.blog.layout = 'application'

# If you want to activate the built-in spam filter, visit http://akismet.com/
# and sign up for an API key.
Rails.application.config.rakismet.key = ENV['RAKISMET_KEY']

# The URL of your blog, for use by Akismet's spam filter.
Rails.application.config.rakismet.url = ENV['RAKISMET_URL']

# Disable the Akismet middleware, because it isn't needed by
# blog.  If you use Akismet elsewhere in your application, you
# may to set this back to true.
Rails.application.config.rakismet.use_middleware = false
