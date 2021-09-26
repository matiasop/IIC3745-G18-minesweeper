require_relative 'user_interface'
require_relative 'board'

class GameMatch
    
    def initialize(match_board)
        @match_board = match_board
        @game_over = false
        @win = false
    end

    def play_turn
        command = UserInterface::receive_command
        if command["action"] == "exit"
            exit()
        else
            result = @match_board.apply_action_to_block(command["action"], command["row"], command["col"])
            if !result
                @game_over = true
            else
                if @match_board.played_blocks == @match_board.win_condition
                    @win = true
                end
            end
        end
    end 

    def do_match
        @match_board.populate_blocks
        @match_board.mark_contiguous
        @match_board.do_blocks_counting
        while !@game_over && !@win do
            UserInterface::show_board(@match_board)
            play_turn
        end
        UserInterface::show_results(@match_board, @win)
    end

end
