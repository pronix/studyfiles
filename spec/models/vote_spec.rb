require 'spec_helper'

describe Vote do
  describe "Check vote" do
    it "Should update rating for document, as positive" do
      @user = Factory(:user)
      @univer = Factory(:university)
      @folder_p = Factory(:folder)
      @folder_c = Factory(:folder)
      @folder_c.parent = @folder_p
      @folder_c.save
      @doc = Factory(:document, :user => @user, :folder => @folder_c, :university => @univer)
      @vote_user = Factory(:user)

      Vote.create(:user => @vote_user, :document => @doc, :vote_type => true, :grade => 1)

      @doc.quick_rating.should == 1
      @doc.rating.should == 1
      @user.quick_rating.should == 1
      @folder_c.quick_rating.should == 1
      @folder_p.quick_rating.should == 1
      @univer.quick_rating.should == 1
    end

    it "Should update rating for document, as not positive" do
      @user = Factory(:user)
      @univer = Factory(:university)
      @folder_p = Factory(:folder)
      @folder_c = Factory(:folder)
      @folder_c.parent = @folder_p
      @folder_c.save
      @doc = Factory(:document, :user => @user, :folder => @folder_c, :university => @univer)
      @vote_user = Factory(:user)

      Vote.create(:user => @vote_user, :document => @doc, :vote_type => false, :grade => 1)
      @doc.quick_rating.should == -1 
      @doc.rating.should == -1
      @user.quick_rating.should == -1
      @folder_c.quick_rating.should == -1
      @folder_p.quick_rating.should == -1
      @univer.quick_rating.should == -1
    end
  end
end
