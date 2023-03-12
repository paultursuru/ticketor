module TicketHelper
  def username(ticket)
    ticket.user == current_user ? "You" : ticket.user.username.capitalize
  end

  def created_on(ticket)
    if ticket.today?
      ticket.created_at.strftime("today at %H:%M")
    else
      ticket.created_at.strftime("on %B #{ticket.created_at.day.ordinalize} at %H:%M")
    end
  end

  def owned_by_me?(ticket)
    ticket.user == current_user
  end
end
