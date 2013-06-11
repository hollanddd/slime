# Require lib and config stuffs
Dir["#{APP_ROOT}/lib/*.rb"].each { |file| require file }

require "#{APP_ROOT}/config/routes.rb" 

# Require models
Dir["#{APP_ROOT}/app/models/*.rb"].each { |model| require model }

# Establish db connection
dbyaml = File.open "#{APP_ROOT}/config/database.yml"
dbconfig = YAML.load dbyaml
ActiveRecord::Base.establish_connection dbconfig['development']
