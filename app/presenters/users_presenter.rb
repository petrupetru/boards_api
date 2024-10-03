class UsersPresenter
    def initialize(users)
        @users = users
    end

    def as_json
        @users.map {|user| UserPresenter.new(user).as_json} 
    end

end