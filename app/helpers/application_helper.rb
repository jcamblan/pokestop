module ApplicationHelper
  def pokemon_name_by_id(id)
  	Pokemon.find(id).name
  end
end
