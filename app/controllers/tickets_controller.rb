class TicketsController < ApplicationController
  def index
    @tickets = Ticket.pending.ordered
    @ticket = Ticket.new
  end

  def day_recap
    redirect_to root_path unless current_user.is_team?
    # change data depending on date params
    @ticket_resolved = Ticket.from_today.resolved
    @ticket_count = @ticket_resolved&.count
    average_duration_in_words unless @ticket_count == 0
  end

  def average_duration_in_words
    seconds = (@ticket_resolved.map(&:duration).sum / @ticket_count)
    minutes = seconds / 60
    if seconds > 60
      @ticket_unit = 'minute'
      @ticket_duration =  minutes
    else
      @ticket_unit = 'second'
      @ticket_duration =  seconds
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    @tickets = Ticket.pending.ordered
    @ticket.attribute_teacher!
    if @ticket.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Ticket created 😉" }
        format.turbo_stream { flash.now[:notice] = "Ticket created 😉" }
      end
      @ticket.broadcast_append_to "tickets"
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity, alert: "you must give some content to your ticket" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@ticket, partial: "tickets/form", locals: { ticket: @ticket }) }
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    if user_can_destroy?(@ticket)
      @ticket.resolved! # avoid @ticket.destroy because we want to keep the ticket in the database for stats
      respond_to do |format|
        format.html { redirect_to root_path, status: :see_other, notice: "Ticket resolved 🔥" }
        format.turbo_stream { flash.now[:notice] = "Ticket resolved 🔥" }
      end
      # remove the ticket from the page only if the user is the owner of the ticket or if the user is a team member
      @ticket.broadcast_remove_to "tickets"
    else
      respond_to do |format|
        format.turbo_stream { flash.now[:alert] = "This ticket is not yours" }
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:content)
  end

  def user_can_destroy?(ticket)
    ticket.user == current_user || current_user.is_team?
  end
end
