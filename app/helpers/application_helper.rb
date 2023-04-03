module ApplicationHelper
  def username(something)
    something.user == current_user ? "You" : something.user.username.titleize
  end

  def created_on(something)
    if something.today?
      something.created_at.strftime("today at %H:%M")
    else
      something.created_at.strftime("on %B #{something.created_at.day.ordinalize} at %H:%M")
    end
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flashes", partial: "shared/flashes"
  end
end
