module PostsHelper
  def post_body_preview post 
    html = markdown(post)
    html.truncate(600, separator: "</p>")
  end

  def markdown(post)
    html = RDiscount.new(post.body).to_html
    html =html.sub(/^<h1>(.+)<\/h1>/m) {
      render partial: 'posts/post_header', locals: { 
                    title: $1,
                    path: post_path(post),
                    date: post.created_at
                  }
    }
    html.html_safe
  end
end

