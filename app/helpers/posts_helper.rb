module PostsHelper
  def post_body_preview post 
    html = markdown(post, true)
  end

  def markdown(post, trunkate=false)
    if trunkate
      html = RDiscount.new(post.body.truncate(600)).to_html
    else
      html = RDiscount.new(post.body).to_html
    end
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

