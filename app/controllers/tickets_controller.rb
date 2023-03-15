class TicketsController < ApplicationController
  def index
    @tickets = Ticket.pending.order(created_at: :desc)
    @ticket = Ticket.new
  end

  def day_recap
    redirect_to root_path unless user_is_team?
    # change data depending on date params
    @ticket_resolved = Ticket.resolved
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

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    @tickets = Ticket.all.order(created_at: :desc)
    if @ticket.save
      redirect_to root_path
      flash.notice = "Ticket created 😉"
    else
      render :index, status: :unprocessable_entity
      flash.alert = "you must give some content to your ticket"
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    redirect_to root_path unless user_can_destroy?(ticket)
    ticket.resolved!
    # ticket.destroy
    redirect_to root_path, status: :see_other
    flash.notice = 'ticket destroyed 🔥'
  end

  private

  def ticket_params
    params.require(:ticket).permit(:content)
  end

  def user_can_destroy?(ticket)
    ticket.user == current_user || user_is_team?
  end

  def user_is_team?
    current_user.teacher? || current_user.assistant?
  end
end
