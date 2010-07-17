class Entry < ActiveRecord::Base
  belongs_to :log
  belongs_to :user
  has_one :location

  validates_presence_of :status_id, :location_id
end
