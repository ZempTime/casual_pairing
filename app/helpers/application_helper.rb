module ApplicationHelper
  def matches_made
    return nil unless user_signed_in?

    "<span class='label label-pill label-danger'>#{current_user.matches.made.count}</span>" if current_user.matches.made.any?
  end
end
