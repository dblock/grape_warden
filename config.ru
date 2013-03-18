require File.join(File.dirname(__FILE__), 'api', 'gwar')

if ENV['RACK_ENV'] == 'development'

end

Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| GWAR::User.find_by_id(id) }

use Rack::Session::Cookie, :secret => "replace this with some secret key"

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = GWAR::FailureApp
end

run GWAR::API
