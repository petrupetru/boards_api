class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @roles = Role.all
        @user = User.new
    end

    def create
        @roles = Role.all
        @user = User.new(user_params)
        if @user.save
            puts params[:user][:role_ids]
            @user.role_ids = params[:user][:role_ids] || []
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end

    end

    def edit
        @roles = Role.all
        @user = User.find(params[:id])
    end

    def update
        @roles = Role.all
        @user = User.find(params[:id])
        if @user.update(user_params)
            @user.role_ids = params[:user][:role_ids] || []
            redirect_to @user
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy

        redirect_to "/users", status: :see_other
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, role_ids: [])
        end
        
end
