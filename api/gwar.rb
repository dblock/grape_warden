require 'grape'
require 'warden'

module GWAR
  class API < Grape::API
    format :json

    get "ping" do
      { "answer" => "pong" }
    end

    get "warden" do
      env['warden'].authenticate!
      { "status_code" => 200, "status_text" => "Authorized"}
    end

    get "info" do
        env['warden'].authenticate!
        env['warden'].user.name
    end

    get 'unauthenticated' do
        { "status_code" => 401, "status_text" => "Unauthorized"}
    end

    post 'login' do
        env['warden'].authenticate(:password)
    end
  end

  class User
    attr_reader :name
    attr_reader :id
    def initialize(name)
        @name = name
        @id = 2013
    end

    def self.get(id)
        return User.new('susan')
    end

    def self.authenticate(u, p)
        return User.new('susan')
    end
  end
end
