require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  test "should set number_id before_create" do
    reply = FactoryGirl.build :reply
    assert_nil reply.number_id
    reply.save
    assert_equal 1, reply.number_id
    assert_equal 2, FactoryGirl.create(:reply).number_id

    assert_equal reply, Reply.number(reply.number_id)
  end

  test "should update topic's actived_at column" do
    topic = FactoryGirl.create :topic
    topic.update_attribute :actived_at, 1.hour.ago
    old_time = topic.actived_at
    FactoryGirl.create :reply, :topic => topic
    assert_not_equal old_time.to_i, topic.actived_at.to_i
  end

  test "should mark replier to topic" do
    topic = FactoryGirl.create :topic
    user = FactoryGirl.create :user
    FactoryGirl.create :reply, :topic => topic, :user => user
    
    assert topic.reload.replied_by?(user)
  end

  test "should inc topic's replies_count column" do
    topic = FactoryGirl.create :topic
    assert_equal 0, topic.replies_count
    assert_difference "topic.reload.replies_count" do
      FactoryGirl.create :reply, :topic => topic
    end
  end

  test "should reset topic's actived_at" do
    topic = FactoryGirl.create :topic
    reply = FactoryGirl.create :reply, :topic => topic
    reply_other = FactoryGirl.create :reply, :topic => topic, :created_at => 1.minutes.from_now
    reply_other.destroy
    assert_equal reply.created_at.to_i, topic.actived_at.to_i
  end

  test "should set topic's last_reply_user" do
    topic = FactoryGirl.create :topic
    reply = FactoryGirl.create :reply, :topic => topic
    assert_equal reply.user, topic.last_reply_user
  end

  test "should reset topic's last_reply_user" do
    topic = FactoryGirl.create :topic
    reply = FactoryGirl.create :reply, :topic => topic
    reply_other = FactoryGirl.create :reply, :topic => topic
    reply_other.destroy
    assert_equal reply.user, topic.last_reply_user
    reply.destroy
    assert_nil topic.last_reply_user
  end

  test "should not send mention notfication to topic user" do
    topic = FactoryGirl.create :topic
    assert_no_difference "topic.user.notifications.where(:_type => 'Notification::Mention').count" do
      FactoryGirl.create :reply, :topic => topic, :content => "@#{topic.user.name}"
    end
  end

  test "should send topic reply notification" do
    topic = FactoryGirl.create :topic
    reply = nil
    assert_difference "topic.user.notifications.unread.count" do
      reply = FactoryGirl.create :reply, :topic => topic
    end
    assert_no_difference "topic.user.notifications.unread.count" do
      FactoryGirl.create :reply, :topic => topic, :user => topic.user
    end
    assert_difference "topic.user.notifications.count", -1 do
      reply.destroy
    end
  end
end
