# -*- encoding : utf-8 -*-
require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test "should build with fragment" do
    site = FactoryGirl.create :site
    assert_not_nil site.fragment
  end
end
