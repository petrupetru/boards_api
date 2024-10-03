class RolePresenter
    def initialize(role)
        @role = role
    end

    def as_json
        user_emails = @role.users.map {|user| user.email}
        role_json = {
            id: @role.id,
            name: @role.name,
            users: user_emails,
            created_at: @role.created_at,
            updated_at: @role.updated_at,
            deleted_at: @role.deleted_at
        }
    end

end    