require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @user = users(:regular)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'another@example.com', username: 'Obiwan', password: '12345678' }
    end
    user = assigns(:user)
    assert_redirected_to user_path(user)
    assert_equal 'another@example.com', user.email
    assert_equal 'Obiwan', user.username
    assert_equal "Welcome to the site!", flash[:notice]
  end

  test "should not create user" do
    assert_no_difference('User.count') do
      post :create, user: { email: 'another@example.com', username: 'Obiwan', password: '123' }
    end
    user = assigns(:user)
    assert_template :new
    assert_equal "Password is too short (minimum is 6 characters)", flash[:error]
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: 'new@example.com', username: "Another Name" }
    assert_redirected_to user_path(assigns(:user))
    assert_equal "Another Name", assigns(:user).username
    assert_equal "new@example.com", assigns(:user).email
  end

  test "should not update user" do
    patch :update, id: @user, user: { email: @admin.email, username: "Another Name" }
    assert_template :edit
    assert_equal 'Email has already been taken', flash[:error]
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end

  test "should not destroy user as regular user" do
    sign_in(@user)
    assert_no_difference('User.count') do
      delete :destroy, id: @user
    end
    assert_redirected_to root_path
  end
end
