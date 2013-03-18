require 'grape'
require 'warden'

module GWAR
  class API < Grape::API
    format :json

    get "ping" do
      { "answer" => "pong" }
    end

    get "warden" do
      env['warden']
    end

  end

  class FailureApp

  end

  class User
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def find_by_id(id)
        return User.new('susan')
    end
    def self.authenticate(u, p)
        return User.new('susan')
    end
  end
end
