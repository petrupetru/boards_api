class ActionItemPolicy  < ApplicationPolicy
    attr_reader :user, :action_item

    def initialize(user, action_item)
        @user = user
        @action_item = action_item
    end

    def index?
        check_view(user)
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