# -*- encoding : utf-8 -*-
class Notification::TopicReply < Notification::Base
  belongs_to :reply

  validates :reply, :presence => true
end
