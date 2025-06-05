# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @book = books(:rails_textbook)
    user = users(:alice)
    sign_in user
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should show Report' do
    visit books_url
    click_on 'この本を表示', match: :first
    assert_text 'タイトル'
    assert_text 'メモ'
    assert_text '著者'
    click_on '本の一覧に戻る'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: 'プロを目指す人のためのRuby入門[改訂2版]'
    fill_in 'メモ', with: '素晴らしい本です！'
    fill_in '著者', with: '伊藤 淳一'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'プロを目指す人のためのRuby入門[改訂2版]'
    assert_text '素晴らしい本です！'
    assert_text '伊藤 淳一'
    click_on '本の一覧に戻る'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first

    fill_in 'タイトル', with: '独習Ruby on Rails'
    fill_in 'メモ', with: '別のの参考書に変更しました！'
    fill_in '著者', with: '小餅 良介'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text '独習Ruby on Rails'
    assert_text '別のの参考書に変更しました！'
    assert_text '小餅 良介'
    click_on '本の一覧に戻る'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first

    assert_text '本が削除されました。'
  end
end
