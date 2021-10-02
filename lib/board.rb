require_relative 'board_block'

class Board 

    attr_accessor :win_condition, :played_blocks
    attr_reader :n_rows, :n_cols, :bomb_spawn_rate, :board


    def initialize(n_rows, n_cols, bomb_spawn_rate)
        @board = {}
        @n_rows = n_rows
        @n_cols = n_cols
        @played_blocks = 0
        @win_condition = 0
        @bomb_spawn_rate = bomb_spawn_rate
    end

    def populate_blocks
        total_bombs = 0
        @n_rows.times do |row|
            @n_cols.times do |col|
              if rand(0.0..1.0) < @bomb_spawn_rate
                @board["(#{row}, #{col})"] = BoardBlock.new(self, true)
                total_bombs += 1
              else
                @board["(#{row}, #{col})"] = BoardBlock.new(self, false)
              end
            end
        end
        @win_condition = (n_rows * n_cols) - total_bombs
    end

    def mark_contiguous
        @n_rows.times do |row|
            @n_cols.times do |col|
                if row > 0
                    @board["(#{row}, #{col})"].contiguous["N"] = @board["(#{row - 1}, #{col})"]
                end

                if col > 0
                    @board["(#{row}, #{col})"].contiguous["W"] = @board["(#{row}, #{col - 1})"]
                end

                if row < @n_rows - 1
                    @board["(#{row}, #{col})"].contiguous["S"] = @board["(#{row + 1}, #{col})"]
                end

                if col < @n_cols - 1
                    @board["(#{row}, #{col})"].contiguous["E"] = @board["(#{row}, #{col + 1})"]
                end
          
                if row > 0 && col > 0 
                    @board["(#{row}, #{col})"].contiguous["NW"] = @board["(#{row - 1}, #{col - 1})"]
                end

                if row > 0 && col < @n_cols - 1
                    @board["(#{row}, #{col})"].contiguous["NE"] = @board["(#{row - 1}, #{col + 1})"]
                end

                if row < @n_rows - 1 && col > 0 
                    @board["(#{row}, #{col})"].contiguous["SW"] = @board["(#{row + 1}, #{col - 1})"]
                end

                if row < @n_rows - 1 && col < @n_cols - 1
                    @board["(#{row}, #{col})"].contiguous["SE"] = @board["(#{row + 1}, #{col + 1})"]
                end
            end
        end
    end

    def do_blocks_counting
        @board.each do |key, value|
            value.count_contiguous_bombs
            value.count_contiguous_zero_blocks
        end
    end

    #Aplica la jugada al bloque elegido
    def apply_action_to_block(action, row, col)
        actual = @board["(#{row}, #{col})"]
        if action == "flag"
            actual.flagged = !actual.flagged
        else
            if actual.bomb 
                return false
            end
            actual.play_block(self)
        end
        return true
    end

    def print_ingame_board
        @n_rows.times do |row|
            @n_cols.times do |col|
                actual = @board["(#{row}, #{col})"]
                if actual.played
                    if actual.n_contiguous_bombs > 0 
                        print "[ " + actual.n_contiguous_bombs.to_s + " ] "
                    else
                        print "[ - ] "
                    end
                elsif actual.flagged
                    print "[|> ] "
                else
                    print "[   ] "
                end
            end
            puts
        end
    end

    def print_hidden_board
        @n_rows.times do |row|
            @n_cols.times do |col|
                actual = @board["(#{row}, #{col})"]
                if actual.bomb
                    print "[ * ] " 
                elsif actual.n_contiguous_bombs > 0 
                    print "[ " + actual.n_contiguous_bombs.to_s + " ] "
                else
                    print "[ - ] "
                end
            end
            puts
        end
    end

end
