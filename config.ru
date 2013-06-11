require 'bundler'
Bundler.setup
Bundler.require
require 'yaml'

APP_ROOT = File.dirname __FILE__
require "#{APP_ROOT}/initializer"

use Rack::Session::Cookie, secret: SecureRandom.hex(128)
use Rack::MethodOverride
use Rack::NestedParams

# setup routing
run Application::Router