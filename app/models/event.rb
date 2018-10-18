class Event < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    title_changed?
  end

  def self.now
    self.where('start_date < ?', DateTime.now).where('end_date > ?', DateTime.now)
  end

  def self.past
    self.where('end_date < ?', DateTime.now)
  end

  def self.future
    self.where('start_date > ?', DateTime.now)
  end

end
