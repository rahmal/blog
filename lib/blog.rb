# Manually require gems, because Bundler won't auto-require them when we're
# running inside a gem.
require "state_machine"
require "cancan"
require "jquery-rails"
require "rdiscount"
require "sanitize"
require "simple_form"
require "kaminari"
require "rakismet"

require "blog/engine"
require "blog/filters"

module Blog
end
