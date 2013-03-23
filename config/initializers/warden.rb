Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| GWAR::User.get(id) }

Warden::Strategies.add(:password) do

  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    u = GWAR::User.authenticate(params['username'], params['password'])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end
