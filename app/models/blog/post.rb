module Blog
  class Post < ActiveRecord::Base
    belongs_to :author, :polymorphic => true
    has_many :comments, :class_name => 'Blog::Comment'

    validates :title, :presence => true
    validates :body, :presence => true
    validates(:state, :presence => true,
              :inclusion => { :in => %w(unpublished published) })
    validates :permalink, :presence => true, :uniqueness => true
    validates :author, :presence => true
    validates :published_at, :presence => true, :if => :published?

    attr_accessible :title, :body, :permalink, :author

    default_scope order: 'updated_at DESC'

    # Recently published posts.  Use this with +limit+.
    scope :recently_published, where(:state => 'published').order('published_at DESC')

    # We use a state machine to represent our publication state.  This is
    # mostly because I visualize a UI with a great big "Publish" button,
    # and not a "Published" checkbox in a form.
    #
    # If you'd like to upgrade your blog into a content-management system
    # with some kind of pre-publication review, just adjust the states and
    # transitions.
    state_machine :state, :initial => :unpublished do
      state :unpublished
      state :published

      event :publish do
        transition :unpublished => :published
      end

      event :unpublish do
        transition :published => :unpublished
      end

      before_transition any => :published do |post, transition|
        post.published_at ||= Time.now
      end
    end

    before_validation :record_author_byline

    protected

    # Since the byline is computed from a polymorphic author association in
    # a complicated fashion, we want to cache it in this object where it's
    # available all the time.
    def record_author_byline
      byline = self.class.author_byline(author)
      self.author_byline = byline unless self.author_byline == byline
    end

    class << self
      # Try to generate a reasonable byline for an author.  We use a
      # +author.byline+ method if present, and default to +author.email+
      # stripped of its domain.
      def author_byline(author)
        case
        when author.respond_to?(:byline) && author.byline
          author.byline
        when author.respond_to?(:email) && author.email
          author.email.sub(/@.*\z/, '')
        else
          'unknown'
        end
      end
    end
  end
end
