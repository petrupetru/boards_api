class BoardPolicy  < ApplicationPolicy
    attr_reader :user, :board

    def initialize(user, board)
        @user = user
        @board = board
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