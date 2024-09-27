class UserPagePolicy  < ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
        @user = user
        @record = record
    end

    def index?
        check_admin(user)
    end

    def show?
        check_admin(user)
    end

    def create?
        check_admin(user)
    end

    def new?
        create?
    end

    def update?
        check_admin(user) 
    end

    def edit?
        update?
    end

    def destroy?
        check_admin(user)
    end
    



end