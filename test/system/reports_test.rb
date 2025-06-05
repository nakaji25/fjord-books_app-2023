# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @report = reports(:one)
    user = users(:alice)
    sign_in user
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should show Report' do
    visit reports_url
    click_on 'この日報を表示', match: :first
    assert_text 'タイトル'
    assert_text '内容'
    assert_text '作成者'
    assert_text '作成日'
    click_on '日報の一覧に戻る'
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
    assert_text 'alice'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end
end
