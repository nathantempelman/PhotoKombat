require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    @picA = pictures(:one)
    @picB = pictures(:two)
    @picB.update_attribute(:rating, 1400)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get compare" do
    get :compare, handle: @category
    assert_response :success
    assert_not_equal assigns(:pic_a), assigns(:pic_b)
  end

  test "should get top" do
    get :top, handle: @category
    assert_response :success
    assert assigns(:pictures)
    assert_equal @picA, assigns(:pictures).first
    assert_equal @picB, assigns(:pictures).last # Last is lower rating
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: { name: 'testing 123'  }
    end

    assert_redirected_to category_path(assigns(:category))
    assert_equal 'testing 123', assigns(:category).name
    assert_equal 'testing-123', assigns(:category).handle
  end

  test "should show category" do
    get :show, handle: @category
    assert_response :success
  end

  test "should get edit" do
    get :edit, handle: @category
    assert_response :success
  end

  test "should update category" do
    patch :update, handle: @category, category: { name: 'testing 2' }
    assert_redirected_to category_path(assigns(:category))
    category = Category.find(@category.id)
    assert_equal 'testing 2', category.name
    assert_equal 'testing-2', category.handle
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, handle: @category
    end
    assert_redirected_to categories_path
  end
end
