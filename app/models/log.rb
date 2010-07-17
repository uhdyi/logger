class Log < ActiveRecord::Base
  belongs_to :serial

  has_many :entries    

  has_one  :latest_entry,
           :class_name => 'Entry',
           :order => 'created_at DESC'

  # validates_presence_of :product_id, :serial_number

  def self.per_page
    30
  end
end
