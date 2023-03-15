module TicketHelper
  def teacher(ticket)
    ticket.teacher == current_user ? "You" : ticket.teacher.username.capitalize
  end

  def owned_by_me?(ticket)
    ticket.user == current_user
  end
end
