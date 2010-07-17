class Serial < ActiveRecord::Base
  belongs_to :product

  def self.search(search, page)
    if search && !search.eql?("")

      paginate :per_page => 15, :page => page,
               :order => 'serial_number ASC',
               :conditions => ['serial_number=?', "#{search}"]
    else

      paginate :per_page => 15, :page => page,
               :order => 'serial_number ASC'
    end
  end

end
