# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/game_match'
require_relative '../lib/board'
require 'test/unit'

# Class to Test game win conditions user actions
class GameMatchTest < Test::Unit::TestCase
  def test_flag_once
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('flag 1 1')
    assert_true board.board['(0, 0)'].flagged
  end

  def test_flag_twice
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('flag 1 1')
    game.play_turn('flag 1 1')
    assert_false board.board['(0, 0)'].flagged
  end

  def test_win
    board = Board.new(8, 8, 0.0)
    game = GameMatch.new(board)
    game.do_match('play 1 1')
    assert_true game.win
  end

  def test_game_over
    board = Board.new(8, 8, 1.0)
    game = GameMatch.new(board)
    game.do_match('play 1 1')
    assert_true game.game_over
  end

  def test_wrong_coordinates
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('flag -1 -1')
    assert_false board.board['(0, 0)'].flagged
  end

  def test_invalid_coordinates_low_row
    board = Board.new(8, 8, 0.5)
    game = GameMatch.new(board)
    assert_false game.valid_coordinates?({ 'action' => 'play', 'row' => -1, 'col' => 3 })
  end

  def test_invalid_coordinates_high_row
    board = Board.new(8, 8, 0.5)
    game = GameMatch.new(board)
    assert_false game.valid_coordinates?({ 'action' => 'play', 'row' => 10, 'col' => 3 })
  end

  def test_invalid_coordinates_low_col
    board = Board.new(8, 8, 0.5)
    game = GameMatch.new(board)
    assert_false game.valid_coordinates?({ 'action' => 'play', 'row' => 3, 'col' => -1 })
  end

  def test_invalid_coordinates_high_col
    board = Board.new(8, 8, 0.5)
    game = GameMatch.new(board)
    assert_false game.valid_coordinates?({ 'action' => 'play', 'row' => 3, 'col' => 8 })
  end

  def test_valid_coordinates
    board = Board.new(8, 8, 0.5)
    game = GameMatch.new(board)
    assert_true game.valid_coordinates?({ 'action' => 'play', 'row' => 3, 'col' => 4 })
  end

  def test_invalid_action
    board = Board.new(8, 8, 0.0)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('invalid')
    assert_false board.board['(0, 0)'].flagged
  end

  def test_valid_action
    board = Board.new(8, 8, 0.0)
    board.populate_blocks
    game = GameMatch.new(board)
    assert_true game.valid_action?('play')
  end

  def test_empty_action
    board = Board.new(8, 8, 0.0)
    board.populate_blocks
    game = GameMatch.new(board)
    assert_false game.valid_action?('')
  end

  def test_string_coordinates
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('play a b')
    assert board.played_blocks.zero?
  end

  def test_float_coordinates
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('play 1.5 1.4')
    assert board.played_blocks.zero?
  end
end
