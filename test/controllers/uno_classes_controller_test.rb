require 'test_helper'

class UnoClassesControllerTest < ActionController::TestCase
  setup do
    @uno_class = uno_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uno_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uno_class" do
    assert_difference('UnoClass.count') do
      post :create, uno_class: { course: @uno_class.course, days: @uno_class.days, department: @uno_class.department, endTime: @uno_class.endTime, instructor: @uno_class.instructor, location: @uno_class.location, section: @uno_class.section, sessionId: @uno_class.sessionId, startTime: @uno_class.startTime }
    end

    assert_redirected_to uno_class_path(assigns(:uno_class))
  end

  test "should show uno_class" do
    get :show, id: @uno_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uno_class
    assert_response :success
  end

  test "should update uno_class" do
    patch :update, id: @uno_class, uno_class: { course: @uno_class.course, days: @uno_class.days, department: @uno_class.department, endTime: @uno_class.endTime, instructor: @uno_class.instructor, location: @uno_class.location, section: @uno_class.section, sessionId: @uno_class.sessionId, startTime: @uno_class.startTime }
    assert_redirected_to uno_class_path(assigns(:uno_class))
  end

  test "should destroy uno_class" do
    assert_difference('UnoClass.count', -1) do
      delete :destroy, id: @uno_class
    end

    assert_redirected_to uno_classes_path
  end
end
