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

    get "version" do
        {"answer" => "GWAR"}
    end


  end

  class FailureApp

  end

  class User
    def find_by_id(id)
        return 'Susan'
    end
  end
end
