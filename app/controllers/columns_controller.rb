class ColumnsController < ApplicationController
    before_action :set_board
    before_action :set_paper_trail_whodunnit

    def index
        @columns = Column.all
    end

    def show
        @column = @board.columns.find(params[:id])
    end

    def new
        @column = Column.new
    end

    def create
        @column = Column.new(column_params)
        if @column.save
            redirect_to @column
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @column = Column.find(params[:id])
    end

    def update
        @column = Column.find(params[:id])
        if @column.update(column_params)
            redirect_to @column
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @column = Column.find(params[:id])
        @column.destroy

        redirect_to root_path, status: :see_other
    end

    private
    def column_params
        params.require(:column).permit(:name)
    end

    def set_board
        @board = Board.find(params[:board_id])
    end
    
end
