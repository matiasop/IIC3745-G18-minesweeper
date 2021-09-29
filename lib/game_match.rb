# frozen_string_literal: true

require_relative 'user_interface'
require_relative 'board'

# Manages game loop and win condition
class GameMatch
  def initialize(match_board)
    @match_board = match_board
    @game_over = false
    @win = false
  end

  def play_turn(player_choice)
    command = UserInterface.receive_command(player_choice)
    result = @match_board.apply_action_to_block(command['action'], command['row'], command['col'])
    if !result
      @game_over = true
    elsif @match_board.played_blocks == @match_board.win_condition
      @win = true
    end
  end

  def do_match(player_choice = '')
    @match_board.populate_blocks
    @match_board.mark_contiguous
    @match_board.do_blocks_counting
    while !@game_over && !@win
      UserInterface.show_board(@match_board)
      play_turn(player_choice)
    end
    UserInterface.show_results(@match_board, @win)
  end
end
