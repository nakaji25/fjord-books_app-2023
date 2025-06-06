# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @report = reports(:one)
    @report_two = reports(:two)
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
    assert_equal Date.current, report.created_on
    assert_not_equal DateTime.current, report.created_on
  end

  test '#save_mentions' do
    mention = Report.new(id: 3, user: @alice, title: 'mention_test', content: 'http://localhost:3000/reports/1\n')
    not_mention = Report.new(id: 4, user: @bob, title: 'not_mention_test', content: 'hogehoge')
    assert_not_empty mention.send(:save_mentions)
    assert_empty not_mention.send(:save_mentions)
  end
end
