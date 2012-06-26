# -*- encoding : utf-8 -*-
require 'test_helper'
require 'functional/admin/base_controller_test'

class Admin::DashboardControllerTest < Admin::BaseControllerTest
  def setup
    @topic = FactoryGirl.create :topic
    @reply = FactoryGirl.create :reply
    @user = FactoryGirl.create :user
  end

  test "shoud show dashboard" do
    assert_require_admin do
      get :show
    end
    assert_response :success, @response.body
  end
end
