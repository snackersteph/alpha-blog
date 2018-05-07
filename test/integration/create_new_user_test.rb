require 'test_helper'

class CreateNewUsersTest < ActionDispatch::IntegrationTest

  test "Sign up new user successful" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "Dave", email: "dave@example.com", password: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "Dave", response.body
  end

end