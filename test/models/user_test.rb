# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    alice = users(:alice)
    assert_equal 'alice', alice.name_or_email
    no_name = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', no_name.name_or_email
  end
end
