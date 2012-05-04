module Blog
  class Ability
    include CanCan::Ability

    def initialize(user)
      can_read_blog
      if user && blog_admin?(user)
        can_manage_blog
      end
    end

    protected

    def admin?(user)
      method = Rails.configuration.blog.blog_admin_method
      if user.respond_to?(method)
        user.send(method)
      else
        raise "You must define #{method} on your user model, as described in README.md"
      end
    end

    def can_read_blog
      can :read, Blog::Post
      can [:read, :create], Blog::Comment
    end

    def can_manage_blog
      alias_action :mark_as_spam, :to => :update
      alias_action :mark_as_ham, :to => :update

      can :manage, Blog::Post
      can :update, Blog::Comment
    end
  end
end
