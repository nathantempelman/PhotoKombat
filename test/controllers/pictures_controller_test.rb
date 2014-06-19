require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    @picture = pictures(:one)
    @pictureb = pictures(:two)
  end

  test "should get index" do
    get :index, category_handle: @category
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should get new" do
    get :new, handle: @category
    assert_response :success
  end

  test "should create picture" do
    assert_difference('Picture.count') do
      post :create, category_handle: @category, picture: { name: @picture.name, rating: @picture.rating, url: @picture.url, user_id: @picture.user_id }
    end

    assert_redirected_to category_picture_path(@category, assigns(:picture))
  end

  test "should show picture" do
    get :show, category_handle: @category, id: @picture
    assert_response :success
  end

  test "should get edit" do
    get :edit, category_handle: @category, id: @picture
    assert_response :success
  end

  test "should update picture" do
    patch :update, category_handle: @category, id: @picture, picture: { name: @picture.name, rating: @picture.rating, url: @picture.url, user_id: @picture.user_id }
    assert_redirected_to category_picture_path(@category, assigns(:picture))
  end

  test "should destroy picture" do
    assert_difference('Picture.count', -1) do
      delete :destroy, category_handle: @category, id: @picture
    end

    assert_redirected_to compare_category_path(@category)
  end

  test "should post to compare submit" do
    pic_a_rating = @picture.rating
    pic_b_rating = @pictureb.rating

    post :compare_submit, category_handle: @category, winner_id: @picture, loser_id: @pictureb
    assert_redirected_to compare_category_path(@category)

    picA = Picture.find(@picture)
    picB = Picture.find(@pictureb)

    assert_not_equal picA.rating, picB.rating
    assert picA.rating > 1500, "Picture A rating was not more than 1500"
    assert picB.rating < 1500, "Picture A rating was not more than 1500"
  end
end
