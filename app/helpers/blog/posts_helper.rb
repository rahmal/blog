module Blog
  module PostsHelper


    def link_to_comments_section(post)
      if post.comments.visible.empty?
        link_to("Comment", permalink_path(post) + "#comments")
      else
        link_to(pluralize(post.comments.visible.count, 'comment'),
                permalink_path(post) + "#comments")
      end
    end


  end
end
