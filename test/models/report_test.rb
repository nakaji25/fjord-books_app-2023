# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @report = reports(:alice_report)
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

  test '#言及した日報が正しくmentioning_reportsに追加されるかのテスト' do
    not_mention = Report.new(title: 'mention_test', content: 'hoge', user: @alice)
    not_mention.save!
    assert_empty not_mention.mentioning_reports
    mention = Report.new(title: 'not_mention_test', content: "http://localhost:3000/reports/#{@report.id}\n", user: @bob)
    mention.save!
    assert_not_empty mention.mentioning_reports
    assert_equal @report.id, mention.mentioning_reports[0]['id']
  end
end
