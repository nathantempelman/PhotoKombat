# This is used in the views to help show the optimal view output
module ActivitiesHelper
  def key_word_for_activity(activity, current_user)
    if ["Picture"].include?(activity.trackable_type)
      ""
    elsif current_user == activity.trackable
      "their profile"
    else
      indefinite_articlerize(activity.trackable_type)
    end
  end
 
  def glyphicon_class_for_action(action)
    if action == "updated"
      "glyphicon-repeat"
    elsif action == "created"
      "glyphicon-asterisk"
    elsif action == "deleted"
      "glyphicon-remove"
    elsif action == "changed their password"
      "glyphicon-lock"
    elsif action == "photo combatted!"
      "glyphicon-camera"
    else
      "glyphicon-question-sign"
    end
  end
 
  def indefinite_articlerize(params_word)
    %w(a e i o u).include?(params_word[0].downcase) ? "an #{params_word}" : "a #{params_word}"
  end

  def format_params_value(key, value)
    if value.starts_with?("http") && key.to_s.include?("image")
      "<img src='#{value}' width='300'>".html_safe
    else
      value.humanize
    end
  end
end
