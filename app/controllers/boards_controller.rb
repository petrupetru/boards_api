class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @users = User.all
    @board = Board.find(params[:id])
    @columns = @board.columns
    @task = Task.new
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      create_default_columns(@board)
      redirect_to @board
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to @board
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def board_params
      params.require(:board).permit(:name)
    end

    def create_default_columns(board)
      default_columns = ['icebox', 'pending', 'in-progress', 'finished', 'delivered']
      default_columns.each do |column_name|
        board.columns.create(name: column_name)
      end
    end

end
