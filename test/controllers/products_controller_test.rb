require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @product.image.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'image.jpg')), filename: 'image.jpg', content_type: 'image/jpg')
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select "h1", "Products"
  end

  test "should get new" do
    get new_product_url
    assert_response :success
    assert_select "h1", "New Product"
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
    assert_select "h2", @product.name
  end

  test "should increase stock" do
    assert_difference('@product.reload.quantity', 1) do
      patch increase_stock_product_url(@product, amount: 1)
    end
    assert_redirected_to products_url
  end

  test "should decrease stock" do
    assert_difference('@product.reload.quantity', -1) do
      patch decrease_stock_product_url(@product, amount: 1)
    end
    assert_redirected_to products_url
  end
end
