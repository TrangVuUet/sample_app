require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
 
  test "should get new" do
    get login_path # Rails ko hieu login_path cua session nao
    assert_response :success
  end

end
