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
    assert_equal Date.current, @report.created_on
  end

  test '#mentions_test' do
    not_mention = Report.new(title: 'mention_test', content: 'hoge', user: @alice, )
    not_mention.save
    mention = Report.new(title: 'not_mention_test', content: 'http://localhost:3000/reports/980190963\n', user: @bob)
    mention.save
    assert_not_empty mention.mentioning_reports
    assert_empty not_mention.mentioning_reports
  end
end
