require 'yaml'
require 'logger'
require 'active_record'

namespace :db do
  def create_database config
	  options = { charset: 'utf8', collation: 'utf8_unicode_ci' }
		create_db = lambda do |config|
		  ActiveRecord::Base.establish_connection config.merge('database' => nil)
			ActiveRecord::Base.connection.create_database config['database'], options
			AcitveRecord::Base.establish_connection config
		end

		begin
		  create_db.call config
		rescue PG::Error => error
		  error.inspect
		end
	end
  
	task :environment do 
	  DATABASE_ENV = ENV['DATABASE_ENV'] || 'development'
		MIGRATIONS_DIR = ENV['MIGRATIONS_DIR'] || 'db/migrate'
	end

	task :configuration => :environment do 
	  @config = YAML.load_file('config/database.yml')[DATABASE_ENV]
	end

	task :configure_connection => :configuration do
	  ActiveRecord::Base.establish_connection @config
		ActiveREcord::Base.logger = Logger.new STDOUT if @config['logger']
	end

	desc 'Create teh database from config/database.yml for the current ENVIRONMENT'
	task :create => :configure_connection do
	  create_database @config
	end

	desc 'Drops the database for the current ENVIRONMENT'
	task :drop => :configure_connection do
	  ActiveRecord::Base.connection.drop_database @config['database']
	end

	desc 'Migrate the database (options: VERSION=x, VERBOSE=false).'
	task :migrate => :configure_connection do
	  ActiveRecord::Migration.verbose = true
		ActiveRecord::Migrator.migrate MIGRATIONS_DIR, ENV['VERSION'] ? ENV['VERSION'].to_i : nil
	end

	desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
	task :rollback => :configure_connection do
	  step = ENV['STEP'] ? ENV['STEP'].to_i : 1
		ActiveRecord::Migrator.rollback MIGRATIONS_DIR, step
	end

	desc 'Retrieves the current schema version number'
	task :version => :configure_connection do
	  puts "Current version: #{ActiveRecord::Migrator.current_version}"
	end
end
