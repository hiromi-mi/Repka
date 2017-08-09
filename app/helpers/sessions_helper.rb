module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    not current_user.nil?
  end

  def is_power_ge?(needed_power)
    logged_in? and current_user.power >= needed_power
  end

  def power_of(role)
    case role
    when :root
      5
    when :shiketai
      2
    when :normal
      1
    else
      0
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
