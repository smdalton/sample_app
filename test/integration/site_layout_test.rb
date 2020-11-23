require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  # assert_select "div"	<div>foobar</div>
  # assert_select "div", "foobar"	<div>foobar</div>
  # assert_select "div.nav"	<div class="nav">foobar</div>
  # assert_select "div#profile"	<div id="profile">foobar</div>
  # assert_select "div[name=yo]"	<div name="yo">hey</div>
  # assert_select "a[href=?]", '/', count: 1	<a href="/">foo</a>
  # assert_select "a[href=?]", '/', text: "foo"	<a href="/">foo</a>
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 3
    # rails inserts the given path into the ? location
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    title_expression = " | Ruby on Rails Tutorial Sample App"
    assert_equal "Home" + title_expression, full_title("Home")
    assert_equal "Signup" + title_expression, full_title("Signup")
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "Signup | Ruby on Rails Tutorial Sample App"
  end
end
