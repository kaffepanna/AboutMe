module PostsHelper
  def post_body_preview post 
    html = markdown(post)
    html =html.sub(/(<h1>.+<\/h1>)/, 
                     link_to('\1', post,                                                   class: 'post_title'))
    html.truncate(600, separator: '< ')
  end

  def markdown(post)
    html = RDiscount.new post.body.gsub(/#\{(.+)\}/) { eval($1) }
    html.to_html
  end
end
