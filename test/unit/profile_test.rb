require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "should have profile after create user" do
    user = FactoryGirl.create :user
    assert_not_nil user.profile
  end
end
