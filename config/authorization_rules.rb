authorization do
  role :admin do
   has_permission_on :logs, :to =>[:index, :new, :edit, :create, :update, :profile, :get_content,:search, :basic_search, :show_advanced_search, :to_csv, :show, :auto_complete_for_serials_serial_number]
   has_permission_on :serials, :to =>[:index, :show, :new, :edit, :create, :update]
   has_permission_on :locations, :to => [:index,:show, :new, :edit, :create, :update]
   has_permission_on :statuses, :to => [:index, :show, :new, :create, :update]
   has_permission_on :products, :to => [:index, :show, :new, :edit, :create, :update]
   has_permission_on :users, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
   has_permission_on :parser, :to => [:index, :parse_csv]
  end

  role :guest do
    has_permission_on :logs, :to => [:index, :get_content, :search, :basic_search, :show_advanced_search, :show, :auto_complete_for_serials_serial_number]
    has_permission_on :serials, :to => [:index, :show]
    has_permission_on :locations, :to => [:index]
    has_permission_on :statuses, :to => [:index, :show]
    has_permission_on :products, :to => [:index]
  end

  role :user do
    includes :guest
    has_permission_on :users, :to => [:update]
    has_permission_on :logs, :to => [:create, :new, :edit, :update]
    has_permission_on :logs do 
      to :profile
      if_attribute :id => is { user.id }
    end
    has_permission_on :serials, :to => [:new, :create]
    has_permission_on :locations, :to => [:new, :create]
    has_permission_on :statuses, :to => [:new, :create]
    has_permission_on :products, :to => [:new, :create]
  end
end
