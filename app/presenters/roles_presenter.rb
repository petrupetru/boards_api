class RolesPresenter
    def initialize(roles)
        @roles = roles
    end

    def as_json
        @roles.map {|role| RolePresenter.new(role).as_json} 
    end

end