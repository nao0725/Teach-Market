require 'test_helper'

class Public::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @public_article = public_articles(:one)
  end

  test "should get index" do
    get public_articles_url
    assert_response :success
  end

  test "should get new" do
    get new_public_article_url
    assert_response :success
  end

  test "should create public_article" do
    assert_difference('Public::Article.count') do
      post public_articles_url, params: { public_article: { body: @public_article.body, title: @public_article.title } }
    end

    assert_redirected_to public_article_url(Public::Article.last)
  end

  test "should show public_article" do
    get public_article_url(@public_article)
    assert_response :success
  end

  test "should get edit" do
    get edit_public_article_url(@public_article)
    assert_response :success
  end

  test "should update public_article" do
    patch public_article_url(@public_article), params: { public_article: { body: @public_article.body, title: @public_article.title } }
    assert_redirected_to public_article_url(@public_article)
  end

  test "should destroy public_article" do
    assert_difference('Public::Article.count', -1) do
      delete public_article_url(@public_article)
    end

    assert_redirected_to public_articles_url
  end
end
