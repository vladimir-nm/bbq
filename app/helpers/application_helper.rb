module ApplicationHelper
  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def bootstrap_class_for(name)
    { success:"alert-success",
      error:  "alert-danger",
      danger: "alert-danger",
      alert:  "alert-warning",
      notice: "alert-info"
    }[name.to_sym] || name
  end
end
