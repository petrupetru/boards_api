class Boards::Updater
    def call(board, board_params)
        board.update(board_params)
    end
end