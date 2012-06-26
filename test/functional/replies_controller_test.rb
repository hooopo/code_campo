# -*- encoding : utf-8 -*-
require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  def setup
    @user = FactoryGirl.create :user
    @topic = FactoryGirl.create :topic
  end

  test "should get new page" do
    get :new, :topic_id => @topic
    assert_redirected_to login_url

    login_as @user
    get :new, :topic_id => @topic
    assert_response :success, @response.body
  end

  test "should create reply" do
    post :create, :topic_id => @topic, :reply => {:content => 'reply body'}
    assert_redirected_to login_url
    
    login_as @user
    assert_difference "@topic.replies.count" do
      post :create, :topic_id => @topic, :reply => {:content => 'reply body'}
    end
    assert_redirected_to topic_url(@topic)
  end

  test "should get edit page" do
    reply = FactoryGirl.create :reply

    login_as FactoryGirl.create(:user)
    assert_raise Mongoid::Errors::DocumentNotFound do
      get :edit, :id => reply
    end

    login_as reply.user
    get :edit, :id => reply
    assert_response :success, @response.body
  end

  test "should update reply" do
    reply = FactoryGirl.create :reply
    
    login_as FactoryGirl.create(:user)
    assert_raise Mongoid::Errors::DocumentNotFound do
      put :update, :id => reply, :reply => {:content => 'change'}
    end

    login_as reply.user
    put :update, :id => reply, :reply => {:content => 'change'}
    assert_equal 'change', reply.reload.content
    assert_response :redirect, @response.body
  end
end
