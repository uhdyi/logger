require 'spec_helper'

describe LogsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should redirect_to(login)
    end
  end

end
