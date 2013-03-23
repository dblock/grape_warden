require 'user'

module GWAR
  class API < Grape::API

    use Rack::Session::Cookie, :secret => "replace this with some secret key"

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = GWAR::API
    end
    
    format :json

    get "ping" do
      { "answer" => "pong" }
    end

    get "info" do
      env['warden'].authenticate
      error! "Unauthorized", 401 unless env['warden'].user
      { "username" => env['warden'].user.name }
    end

    post 'login' do
      env['warden'].authenticate(:password)
      error! "Invalid username or password", 401 unless env['warden'].user
      { "username" => env['warden'].user.name }
    end
    
  end
end
