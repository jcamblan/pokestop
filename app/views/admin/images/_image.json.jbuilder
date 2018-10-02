json.extract! image, :id, :image_data, :created_at, :updated_at
json.url url_for(image.image)
json.image_url url_for(image.image)