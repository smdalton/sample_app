require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'invalid signup attempt' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: '4444',
                                         password_confirmation: '4441' } }
    end
    assert_template 'users/new'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup attempt' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: 'El Jefe',
                                         email: 'user@valid.com',
                                         password: '7777777',
                                         password_confirmation: '7777777' } }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert_select 'div.alert'
    # assert is_logged_in?
  end



end
