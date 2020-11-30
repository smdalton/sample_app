require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test 'index as admin including pagination and delete links' do

  end

  test 'index including pagination' do
    log_in_as @user
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    assert_select 'img.gravatar', count: 30

    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

end