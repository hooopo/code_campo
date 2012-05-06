require 'test_helper'

class Admin::BaseControllerTest < ActionController::TestCase
  def assert_require_admin
    init_admin
    logout
    assert !logined?
    yield
    assert_redirected_to login_path
    login_as FactoryGirl.create(:user)
    yield
    assert_redirected_to root_path
    login_as @admin
    yield
  end

  def init_admin
    @admin ||= User.where(:email => ENV['cc_admin_emails'].split(",")).first || FactoryGirl.create(:user, :email => ENV['cc_admin_emails'].split(",").first)
  end
end
