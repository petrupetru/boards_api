class BoardsController < ApplicationController
  include LoggerModule

  before_action :authenticate_user!



  def index
    if params.has_key?(:include_columns) and params.has_key?(:include_tasks)
      if params[:include_columns] == "true" and params[:include_tasks] == "false"
        @boards = Board.includes(:columns).all
      elsif params[:include_columns] == "true" and params[:include_tasks] == "true"
        @boards = Board.includes(:columns, :tasks).all
      elsif params[:include_columns] == "false" and params[:include_tasks] == "true"
        @boards = Board.includes(:tasks).all
      else 
        @boards = Board.all
      end
    else
      @boards = Board.all
    end
    
    @users = User.where.not(:id => current_user.id)

    ArchiveTaskJob.perform_async

  end

  def show
    @users = User.all
    @board = Board.find(params[:id])
    authorize @board
    @columns = @board.columns.includes([:tasks])
    @task = Task.new

    LoggerModule.logger.error("################INFO############")
  end

  def new
    @board = Board.new
    authorize @board
  end

  def create
    @board = Board.new(board_params)
    authorize @board
    if @board.save
      create_default_columns(@board)
      redirect_to @board
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = Board.find(params[:id])
    authorize @board
  end

  def update
    @board = Board.find(params[:id])
    authorize @board
    if @board.update(board_params)
      redirect_to @board
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    authorize @board
    @board.destroy

    redirect_to root_path, status: :see_other
  end


  private
    def board_params
      params.require(:board).permit(:name, :include_columns, :include_tasks)
    end

    def create_default_columns(board)
      default_columns = ['icebox', 'pending', 'in-progress', 'finished', 'delivered']
      default_columns.each do |column_name|
        board.columns.create(name: column_name)
      end
    end

end
