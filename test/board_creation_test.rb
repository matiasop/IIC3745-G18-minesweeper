# frozen_string_literal: true

require_relative '../lib/board'
require 'test/unit'

# Class to Test BoardCreation Methods
class BoardCreationTest < Test::Unit::TestCase
  def test_block_and_bomb_spawn_spawning_bomb
    board = Board.new(8, 8, 1)
    board.block_and_bomb_spawn(0, 0)
    assert_true board.board['(0, 0)'].bomb
  end

  def test_block_and_bomb_spawn_not_spawning_bomb
    board = Board.new(8, 8, 0)
    board.block_and_bomb_spawn(0, 0)
    assert_true !board.board['(0, 0)'].bomb
  end

  def test_win_condition_on_population_of_with_no_bombs
    board = Board.new(8, 8, 1)
    board.populate_blocks
    assert_true board.win_condition.zero?
  end

  def test_win_condition_on_population_of_board_full_of_bombs
    board = Board.new(8, 8, 0)
    board.populate_blocks
    assert_true board.win_condition == 64
  end
end
