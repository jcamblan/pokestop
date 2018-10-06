class EventsController < ApplicationController

  breadcrumb 'Events', :events_path

  def calendar
    @events = Event.all.order(:id)
  end

  def show
    breadcrumb @event.name, event_path(@event)
  end

end