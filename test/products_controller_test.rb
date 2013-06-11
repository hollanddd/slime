require_relative "test_helper"

class ProductsControllerTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    OUTER_APP
  end
  
  def test_show_all_products_page
    get "/products"
    assert last_response.ok?
  end
end
