class EventsController < ApplicationController
  def calendar
    @events = Event.all.order(:id)
  end

end