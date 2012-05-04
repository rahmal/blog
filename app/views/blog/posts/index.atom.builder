atom_feed root_url: blog_url, url: feed_url do |feed|
  feed.title t('blog.blog.title')
  feed.updated @posts.first.updated_at
  @posts.each do |post|
    feed.entry(post, published: post.published_at, url: permalink_url(post)) do |entry|
      entry.title post.title
      entry.content markdown(post.body), type: 'html'
      entry.author do |author|
        author.name post.author_byline
      end
    end
  end
end
