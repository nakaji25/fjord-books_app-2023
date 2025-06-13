# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @report = reports(:alice_report)
    user = users(:alice)
    sign_in user
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
    assert_text '[1日目] FBCスタート'
  end

  test 'should show Report' do
    visit reports_url
    click_on 'この日報を表示', match: :first
    assert_text '[1日目] FBCスタート'
    assert_text 'FBCスタート!'
  end

  test 'should create book' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '[2日目] FizzBuzz提出！'
    fill_in '内容', with: '簡単だった！'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '[2日目] FizzBuzz提出！'
    assert_text '簡単だった！'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: '[1日目] 環境構築＆Ruby導入編'
    fill_in '内容', with: '環境構築完了！'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '[1日目] 環境構築＆Ruby導入編'
    assert_text '環境構築完了！'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end
end
