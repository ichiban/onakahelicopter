$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'app'
require 'rack/csrf'

use Rack::Session::Cookie
use Rack::Csrf, :raise => true

run Sinatra::Application