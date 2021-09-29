# frozen_string_literal: true

require_relative 'user_interface'
require_relative 'board'

# Manages game loop and win condition
class GameMatch
  attr_reader :win, :game_over

  def initialize(match_board)
    @match_board = match_board
    @game_over = false
    @win = false
  end

  def valid_coordinates?(command)
    return false if command['row'].negative? || command['row'] > @match_board.n_rows
    return false if command['col'].negative? || command['col'] > @match_board.n_cols

    true
  end

  def turn_logic(command)
    result = @match_board.apply_action_to_block(command['action'], command['row'], command['col'])
    if !result
      @game_over = true
    elsif @match_board.played_blocks == @match_board.win_condition
      @win = true
    end
  end

  def play_turn(player_choice)
    command = UserInterface.receive_command(player_choice)
    if valid_coordinates?(command)
      turn_logic(command)
    else
      UserInterface.invalid_coordinates
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
