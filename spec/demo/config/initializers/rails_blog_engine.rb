# Configure Blog here.

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
