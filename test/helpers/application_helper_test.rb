require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    base_expr = 'Ruby on Rails Tutorial Sample App'
    assert_equal full_title, base_expr
    assert_equal full_title('Home'), "Home | "+base_expr
  end
end