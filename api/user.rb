module GWAR
  class User

    USERS = {
      1 => "Susan",
      2 => "Bob"
    }

    attr_reader :name
    attr_reader :id
    
    def initialize(id, name)
      @id = id
      @name = name
    end

    class << self

      def get(id)
        User.new(id, User::USERS[id])
      end
      
      def authenticate(u, p)
        id = User::USERS.invert[u]
        User.new(id, u) if id
      end

    end

  end
end
