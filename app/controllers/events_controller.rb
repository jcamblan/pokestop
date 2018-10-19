class EventsController < ApplicationController

  breadcrumb 'Events', :events_path

  def calendar
    @events = Event.all.order(:id)
  end

  def show
    @event = Event.friendly.find(params[:id])
    breadcrumb @event.title, event_path(@event)
  end

  def index
    @current_events = Event.now.order(end_date: :asc)
    @past_events = Event.past.order(end_date: :desc).limit(5)
    @future_events = Event.future.order(start_date: :asc).limit(5)
  end

end