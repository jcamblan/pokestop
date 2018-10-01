json.extract! photo, :id, :image_data, :created_at, :updated_at
json.url url_for(photo.image)
json.image_url url_for(photo.image)