module ApplicationHelper
  def logged_in?
    # The !! turns the following variable into a boolean
    !!current_user
  end

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-success'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end
end
