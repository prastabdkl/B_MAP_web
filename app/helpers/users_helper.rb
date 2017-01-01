module UsersHelper

  def gravatar_for(user)
    gravatar_url = user.image.thumb.url
    image_tag(gravatar_url, class: "gravatar")
  end

  def count_admin_users
    User.where(is_admin: true).count
  end

end
