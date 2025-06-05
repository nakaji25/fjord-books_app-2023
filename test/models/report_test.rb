# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @report = reports(:one)
    @alice = users(:alice)
    @bob = users(:bob)
    sign_in @alice
  end

  test '#editable?' do
    report = Report.new(title: 'hoge', content: 'fuga', user: @alice)
    assert report.editable?(@alice)
    assert_not report.editable?(@bob)
  end

  test '#creat_on' do
    report = Report.new(title: 'hoge', content: 'fuga', user: @alice, created_at: Time.current)
    assert report.created_on
  end
end
