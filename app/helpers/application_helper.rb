module ApplicationHelper

  def current_user_owns?(entity)
    current_user&.author?(entity)
  end

end
