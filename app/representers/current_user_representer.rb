class CurrentUserRepresenter < Struct.new(:user)
  def to_h
    {
      name: user.name,
      email: user.email
    }
  end
end
