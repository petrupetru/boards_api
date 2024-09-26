class ActionItemsController < ApplicationController
    def new
        @board = Board.find(params[:board_id])
        @task = Task.find(params[:task_id])
        @action_item = ActionItem.new
    end

    def create
        puts params
        @board = Board.find(params[:board_id])
        @task = Task.find(params[:task_id])

        @action_item = @task.action_items.new(action_item_params)
        if action_item_params[:itemable_type] == 'Photo'
          photo = Photo.new(photo_params)
          @action_item.itemable = photo
        elsif action_item_params[:itemable_type] == 'Document'
          document = Document.new(document_params)
          @action_item.itemable = document
        end

        if @action_item.save

          redirect_to board_task_path(@board, @task), notice: 'Action item was successfully created.'
        else
          render :new
        end
    end


    def edit
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:task_id])
      @action_item = @task.action_items.find(params[:id])
    end

    def update

      @board = Board.find(params[:board_id])
      @task = Task.find(params[:task_id])
      @action_item = @task.action_items.find(params[:id])


      if @action_item.itemable_type == 'Photo'
        if @action_item.itemable.update(photo_params)
          @action_item.update(action_item_params)
          redirect_to board_task_path(@board, @task)
        else
          render :edit
        end
      elsif @action_item.itemable_type == 'Document'
        if @action_item.itemable.update(document_params)
          @action_item.update(action_item_params)
          redirect_to board_task_path(@board, @task)
        else
          render :edit
        end
      else
        redirect_to board_task_path(@board, @task), alert: 'Invalid itemable type.'
      end
    end


    def destroy
      @board = Board.find(params[:board_id])
      @task = @board.tasks.find(params[:task_id])
      @action_item = @task.action_items.find(params[:id])
      @action_item.destroy
      redirect_to board_task_path(@board, @task)

    end




    private

    def action_item_params
      params.require(:action_item).permit(:name, :status, :itemable_type)
    end
    def photo_params
      params.require(:action_item).permit(:photo_source, :content)
    end
    def document_params
      params.require(:action_item).permit(:document_link, :content)
    end

    
end
