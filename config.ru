require File.join(File.dirname(__FILE__), 'api', 'gwar')

if ENV['RACK_ENV'] == 'development'

end

Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| GWAR::User.get(id) }

use Rack::Session::Cookie, :secret => "replace this with some secret key"

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = GWAR::API
end

Warden::Strategies.add(:password) do

  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    u = GWAR::User.authenticate(params['username'], params['password'])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end

run GWAR::API
