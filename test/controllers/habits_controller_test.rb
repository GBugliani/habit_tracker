require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @habit = habits(:one)
    sign_in @user
  end

  test "should get index" do
    get habits_url
    assert_response :success
  end

  test "should get show" do
    get habit_url(@habit)
    assert_response :success
  end

  test "should get new" do
    get new_habit_url
    assert_response :success
  end

  test "should get edit" do
    get edit_habit_url(@habit)
    assert_response :success
  end
end
