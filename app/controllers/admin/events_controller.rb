class Admin::EventsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Events', :admin_events_path

  def index
    @events = Event.all
  end

  def edit
    @event = Event.friendly.find(params[:id])
    breadcrumb @event.title, edit_admin_event_path(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create!(event_params)
    redirect_to edit_admin_event_path(@event)
  end

  def update
    @event = Event.friendly.find(params[:id])
    if @event.update(event_params)
      redirect_to admin_events_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def event_params
      params.require(:event).permit(:title, :headline, :body, :start_date, :end_date, :on_prod)
    end
end