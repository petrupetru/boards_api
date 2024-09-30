class TasksController < ApplicationController
    def index
      @board = Board.find(params[:board_id])
      @tasks = @board.tasks
      authorize Task, policy_class: TaskPolicy
    end

    def show
      @board = Board.find(params[:board_id])
      @task = @board.tasks.includes([action_items: :itemable]).find(params[:id])
      authorize @task, policy_class: TaskPolicy
      @action_item = ActionItem.new

      
    end

    def new
      @task = Task.new
      @users = User.all 
      authorize @task, policy_class: TaskPolicy
    end


    def create
        @board = Board.find(params[:board_id])
        @task = @board.tasks.new(task_params)
        authorize @task, policy_class: TaskPolicy
        @users = User.all
        if @task.save
          @task.user_ids = params[:task][:user_ids] || []
          redirect_to @board
        else
          Rails.logger.error(@task.errors.full_messages.join(", "))
          redirect_to @board
        end
    end

    def edit
      @users = User.all
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      authorize @task, policy_class: TaskPolicy
    end
  
    def update
      @users = User.all
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      authorize @task, policy_class: TaskPolicy
      if @task.class.name == "Task::Bug"
        if @task.update(task_bug_params)
          #puts "######################"
          #puts params
          @task.user_ids = params[:task][:user_ids] || []
          redirect_to board_task_path(@board, @task)
        else
          redirect_to @board, status: :unprocessable_entity
        end
      end
      if @task.class.name == "Task::Feature"
        if @task.update(task_feature_params)
          @task.user_ids = params[:task][:user_ids] || []
          redirect_to board_task_path(@board, @task)
        else
          redirect_to @board, status: :unprocessable_entity
        end
      end
      if @task.class.name == "Task::Support"
        if @task.update(task_support_params)
          @task.user_ids = params[:task][:user_ids] || []
          redirect_to board_task_path(@board, @task)
        else
          redirect_to @board, status: :unprocessable_entity
        end
      end

      
    end

    def destroy
      @board = Board.find(params[:board_id])
      @task = @board.tasks.find(params[:id])
      authorize @task, policy_class: TaskPolicy
      @task.destroy
  
      redirect_to board_path(@board), status: :see_other
    end


  
    
    private
    def task_params
        params.require(:task).permit(:type, :title, :description, :due_date, :users, :column_id)
    end
    def task_bug_params
      params.require(:task_bug).permit(:title, :description, :due_date, :users, :column_id)
    end
    def task_feature_params
      params.require(:task_feature).permit(:title, :description, :due_date, :users, :column_id)
    end
    def task_support_params
      params.require(:task_support).permit(:title, :description, :due_date, :users, :column_id)
    end
end
