class Image < ApplicationRecord
  # include ImageUploader[:image]
  has_one_attached :image
end
