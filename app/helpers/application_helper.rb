module ApplicationHelper
  def menu_link(name, path)
    link_to(name, path, { class: name.downcase == params[:controller] ? 'selected' : '' })
  end
end
