require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "Jessie", email: "jessie@example.com", password: "password", admin: false)
  end

  test "Create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "This is a test article", description: "This is test article's description", category: "sports" } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "Title:", response.body
    assert_match "Description", response.body
  end
end