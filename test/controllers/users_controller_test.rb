# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  test 'should redirect destroy requests when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert assert_redirected_to login_url
  end

  test ' should redirect destroy when logged in as non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test 'assert admin user can delete other user' do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test 'admin not changeable by http patch to users/edit' do
    log_in_as @other_user
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: {
      password: 'password',
      password_confirmation: 'password',
      admin: 1
    } }
    assert_not @other_user.reload.admin?
  end
  # test "should get login" do
  #   get login_path
  #   assert_response :success
  # end
end
