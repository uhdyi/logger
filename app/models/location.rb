class Location < ActiveRecord::Base
belongs_to :entry

validates_uniqueness_of :detail

def name_with_detail
  "#{name}/#{detail}"
end

def self.search(search, page)
  if search && !search.eql?("")
    
    paginate :per_page => 15, :page => page,
             :order => 'name ASC',
             :conditions => ['name LIKE ?', "#{search}"]
  else
    paginate :per_page => 15, :page => page,
             :order => 'name ASC'
  end
end

end
