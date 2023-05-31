require 'test_helper'

class PersonalInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get personal_informations_new_url
    assert_response :success
  end

  test "should get create" do
    get personal_informations_create_url
    assert_response :success
  end

end
