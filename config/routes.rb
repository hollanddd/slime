# config/router.rb

# require controllers; I want this out of here
Dir["#{APP_ROOT}/app/controllers/*.rb"].each{ |f| require f }

module Application
  Router = HttpRouter.new
  Router.get('/products').to ProductsController.action(:index)
end
