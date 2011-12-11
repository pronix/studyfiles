require 'spec_helper'

describe User do
  describe "Roles" do
    it "Should assign role user to new user" do
      @user = Factory(:user)
      @user.is_user?.should == true
    end
  end
end
