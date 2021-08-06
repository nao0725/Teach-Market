require "application_system_test_case"

class Public::ArticlesTest < ApplicationSystemTestCase
  setup do
    @public_article = public_articles(:one)
  end

  test "visiting the index" do
    visit public_articles_url
    assert_selector "h1", text: "Public/Articles"
  end

  test "creating a Article" do
    visit public_articles_url
    click_on "New Public/Article"

    fill_in "Body", with: @public_article.body
    fill_in "Title", with: @public_article.title
    click_on "Create Article"

    assert_text "Article was successfully created"
    click_on "Back"
  end

  test "updating a Article" do
    visit public_articles_url
    click_on "Edit", match: :first

    fill_in "Body", with: @public_article.body
    fill_in "Title", with: @public_article.title
    click_on "Update Article"

    assert_text "Article was successfully updated"
    click_on "Back"
  end

  test "destroying a Article" do
    visit public_articles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Article was successfully destroyed"
  end
end
