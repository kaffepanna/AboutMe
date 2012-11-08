module PostsHelper
  def post_body_preview post 
    html = RDiscount.new post.body.truncate(200, separator: ' ')
    html.to_html.sub(/(\<h1\>.+\<\/h1\>)/, 
                     link_to('\1', post,                                                   class: 'post_title'))
  end
end
