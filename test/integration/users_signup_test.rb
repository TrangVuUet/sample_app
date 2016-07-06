require 'test_helper'

class UersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "",
							 email: "user@invalid",
							 password: "foo",
							 password_confirmation: "bar"}
			end
		assert_template 'users/new' #check new html co hien thi hay ko
	end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name:  "May",
                                          email: "trang94vnu@gmail.com",
                                          password:              "Trang1912",
                                          password_confirmation: "Trang1912" }
    end
    # check if Afer login, redirect to @user page
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end


end
