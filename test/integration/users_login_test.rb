require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # visit the login path
  # verify that the sessions form renders properly
  # post the session path with an invalid params hash
  # verify that the new sessions form gets re-rendered and that a flash message appears
  # visit another page
  # verify that the flash message doesn't appear on the new page
  def setup
    @user = users(:michael)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path params: { session: {email: "", password:""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid email/invalid password' do
    get login_path
    assert_template 'sessions/new'
    post login_path params: { session: { email: @user.email, password: 'argpirate' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert_select "a[href=?]", login_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user

    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0

  end

end
