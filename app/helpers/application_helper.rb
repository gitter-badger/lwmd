module ApplicationHelper

  def resource_name
    :member
  end

  def resource
    @resource ||= Member.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:member]
  end
  
  def flash_class(level)
    case level
      when "success" then "ui green message"
      when "error" then "ui red message"
      else "ui blue message"
    end
  end
end
