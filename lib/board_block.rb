class BoardBlock
    NEIGHBORS = %w[N NE E SE S SW W NW]
    attr_accessor :parent_board, :n_contiguous_bombs, :contiguous_zero_blocks, :played, :flagged, :contiguous
    attr_reader :bomb

    def initialize(parent_board, bomb)
        @parent_board = parent_board
        @bomb = bomb
        @n_contiguous_bombs = 0
        @contiguous_zero_blocks = []
        @played = false
        @flagged = false
        #Using cardinal coordinates
        @contiguous = NEIGHBORS.inject({}){|hash, key| hash[key] = nil; hash}
    end

    def count_contiguous_bombs
        @contiguous.each do |key, value|
            if !value.nil?
                if value.bomb
                    @n_contiguous_bombs += 1
                end 
            end
        end
    end

    def count_contiguous_zero_blocks
        @contiguous.each do |key, value|
            if !value.nil?
                if value.n_contiguous_bombs == 0
                    @contiguous_zero_blocks.push(value)
                end 
            end
        end
    end

    def play_block(board)
        if @played || @flagged
            return
        end
        @played = true
        board.played_blocks += 1
        if @n_contiguous_bombs == 0
            @contiguous.each do |key, value|
                value.play_block(board)
            end 
        end
    end
end
                

