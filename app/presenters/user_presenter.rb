class UserPresenter
    def initialize(user)
        @user = user
    end

    def as_json
        role_names = @user.roles.map {|role| role.name}
        user_json = {
            id: @user.id,
            email: @user.email,
            roles: role_names,
            created_at: @user.created_at,
            updated_at: @user.updated_at,
            deleted_at: @user.deleted_at,    
        }
    end

end    