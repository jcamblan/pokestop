
  json.array!(@events) do |event|
    json.title event.title
    json.url event_path(event)
    json.start event.starting_date
    json.end event.ending_date
    #json.color event.color
  end
