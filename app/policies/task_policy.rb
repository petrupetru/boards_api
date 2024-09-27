class TaskPolicy  < ApplicationPolicy
    attr_reader :user, :task

    def initialize(user, task)
        @user = user
        @task = task
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