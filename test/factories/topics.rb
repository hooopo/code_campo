# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :topic do
    title 'title'
    content 'content'
    tags %w(ruby programing)
    association :user
  end
end
