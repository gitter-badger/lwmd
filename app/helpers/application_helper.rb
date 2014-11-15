module ApplicationHelper
  def flash_class(level)
    case level
      when "success" then "ui green message"
      when "error" then "ui red message"
      else "ui blue message"
    end
  end
end
