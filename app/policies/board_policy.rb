class BoardPolicy  < ApplicationPolicy
    attr_reader :user, :board

    def initialize(user, board)
        @user = user
        @board = board
    end

    def index?
    false
    end

    def show?
        check_view(user)
    end
    

    def create?
        check_edit(user)
    end

    def new?
        create?
    end

    def update?
        check_edit(user)
    end

    def edit?
        update?
    end

    def destroy?
        check_edit(user)
    end
    





end