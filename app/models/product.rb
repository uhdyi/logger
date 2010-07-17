class Product < ActiveRecord::Base
  has_many :serials
  has_many :logs, :through => :serials

  validates_uniqueness_of :part_number
  validates_presence_of :part_number

  def self.search(search, page)
    if search
      paginate :per_page => 15, :page => page,
               :order => 'part_number ASC',
               :conditions => ['id=?', "#{search}"]
    else
      paginate :per_page => 15, :page => page,
               :order => 'part_number ASC'
    end
  end
end
