# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_block'
require_relative '../lib/board'
require 'test/unit'
class BoardBlockTest < Test::Unit::TestCase
  def test_play_corner_00_block
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    board.board["(0, 0)"].play_block(board)
    assert_equal(board.board["(0, 0)"].played, true)
  end

  def test_play_corner_0n_block
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    board.board["(0, 7)"].play_block(board)
    assert_equal(board.board["(0, 7)"].played, true)
  end

  def test_play_corner_n0_block
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    board.board["(7, 0)"].play_block(board)
    assert_equal(board.board["(7, 0)"].played, true)
  end

  def test_play_corner_nn_block
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    board.board["(7, 7)"].play_block(board)
    assert_equal(board.board["(7, 7)"].played, true)
  end

  def test_play_block_in_empty_board
    board = Board.new(8, 8, 0)
    board.populate_blocks
    board.board["(3, 3)"].play_block(board)
    assert_equal(board.board["(3, 3)"].played, true)
  end
end
