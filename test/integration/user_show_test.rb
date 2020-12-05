require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @inactive_user = users(:inactive)
    @active_user = users(:archer)
  end


  test 'should display user when activated' do
    get user_path(@active_user)
    assert_response :success
    assert_template 'users/show'
  end

  test 'should redirect when user not activated' do
    get user_path(@inactive_user)
    assert_response :redirect
    assert assert_redirected_to root_url
  end
end
