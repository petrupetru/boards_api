class UsersController < ApplicationController
    def index
        @users = User.where.not(:id => current_user.id)

        authorize User, policy_class: UserPagePolicy
    end

    def show
        @user = User.find(params[:id])
        authorize @user, policy_class: UserPagePolicy
    end

    def new
        @roles = Role.all
        @user = User.new
        authorize @user, policy_class: UserPagePolicy
    end

    def create
        @roles = Role.all
        @user = User.new(user_params)
        authorize @user, policy_class: UserPagePolicy
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
        authorize @user, policy_class: UserPagePolicy
    end

    def update
        @roles = Role.all
        @user = User.find(params[:id])
        authorize @user, policy_class: UserPagePolicy
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
        authorize @user, policy_class: UserPagePolicy

        redirect_to "/users", status: :see_other
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, role_ids: [])
       
    end

 
    def resource_name
        :user
    end
    helper_method :resource_name
    
    def resource
        @resource ||= User.new
    end
    helper_method :resource
    
    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end
    helper_method :devise_mapping
    
    def resource_class
        User
    end
    helper_method :resource_class


        
end
