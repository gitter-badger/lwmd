class RoleConstraint
  # http://minhajuddin.com/2011/10/24/how-to-change-the-rails-root-url-based-on-the-user-or-role

  def initialize(*roles)
    @roles = roles
  end

  def matches?(request)
    @roles.include? request.env['warden'].user.try(:role)
  end
end
