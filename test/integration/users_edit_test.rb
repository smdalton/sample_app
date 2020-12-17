# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'unsuccesful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template('users/edit')
    patch user_path(@user), params: {
      user: { name: '', email: 'invalid@foo', password: 'kek',
              password_confirmation: 'top' }
    }
    assert_template('users/edit')
    assert_select 'div.alert', text: 'The form contains 4 errors.'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = 'Michael Dalton'
    email = 'jazzgarlicfan@yahoo.com'
    patch user_path(@user), params: {
      user: {
        name: 'Michael Dalton',
        email: 'Jazzgarlicfan@yahoo.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as @other_user
    get edit_user_path @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as other user' do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_redirected_to root_url
  end
end
