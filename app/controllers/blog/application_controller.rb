module Blog
  class ApplicationController < ActionController::Base
    layout :choose_layout

    helper_method :permalink_url
    helper_method :permalink_path

    protected

    # Construct a CanCan Ability object to control access to the blog.
    def current_ability
      method = Rails.configuration.blog.current_user_method
      if respond_to?(method)
        user = send(method)
      else
        raise "You must define #{method} on Blog::ApplicationController, as described in README.md"
      end
      Blog::Ability.new(user)
    end

    # We normally use one of our parent application's layouts, so that we
    # "auto-blend" into the existing look-and-feel of the site.  The
    # specific layout is specified by our initializer.
    def choose_layout
      Rails.configuration.blog.layout
    end

    def permalink_local_path(post)
      date = post.published_at.utc
      sprintf('%04d/%02d/%02d/%s', date.year, date.month, date.day, post.permalink)
    end

    def permalink_path(post)
      blog_path + permalink_local_path(post)
    end

    def permalink_url(post)
      blog_url + permalink_local_path(post)
    end
  end
end
