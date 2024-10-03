class Boards::Creator
    def call(board)
        board.save
        create_default_columns(board)
    end

    def create_default_columns(board)
        default_columns = ['icebox', 'pending', 'in-progress', 'finished', 'delivered']
        default_columns.each do |column_name|
            board.columns.create(name: column_name)
        end
    end
end