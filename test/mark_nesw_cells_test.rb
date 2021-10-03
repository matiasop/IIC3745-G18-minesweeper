# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board'
require 'test/unit'

# Class to Test marking of North, East, South, West neighboors in board
class BoardTest < Test::Unit::TestCase
  def setup
    @board = Board.new(8, 8, 0)
    @board.populate_blocks
  end

  # Test North and South Cases
  def test_mark_up_and_down_cells_north_top_row
    @board.mark_up_and_down_cells_contiguous(0, 0)
    assert_true @board.board['(0, 0)'].contiguous['N'].nil?
  end

  def test_mark_up_and_down_cells_south_top_row
    @board.mark_up_and_down_cells_contiguous(0, 0)
    assert_true @board.board['(0, 0)'].contiguous['S'] == @board.board['(1, 0)']
  end

  def test_mark_up_and_down_cells_north_bottom_row
    @board.mark_up_and_down_cells_contiguous(7, 0)
    assert_true @board.board['(7, 0)'].contiguous['N'] == @board.board['(6, 0)']
  end

  def test_mark_up_and_down_cells_south_bottom_row
    @board.mark_up_and_down_cells_contiguous(7, 0)
    assert_true @board.board['(7, 0)'].contiguous['S'].nil?
  end

  def test_mark_up_and_down_cells_north_non_edge_case
    @board.mark_up_and_down_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['N'] == @board.board['(4, 5)']
  end

  def test_mark_up_and_down_cells_south_non_edge_case
    @board.mark_up_and_down_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['S'] == @board.board['(6, 5)']
  end

  # Test East and West Cases

  def test_mark_sides_cells_west_left_col
    @board.mark_sides_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['W'].nil?
  end

  def test_mark_sides_cells_east_left_col
    @board.mark_sides_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['E'] == @board.board['(5, 1)']
  end

  def test_mark_sides_cells_west_right_col
    @board.mark_sides_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['W'] == @board.board['(5, 6)']
  end

  def test_mark_sides_cells_east_right_col
    @board.mark_sides_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['E'].nil?
  end

  def test_mark_sides_cells_west_non_edge_case
    @board.mark_sides_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['W'] == @board.board['(5, 4)']
  end

  def test_mark_sides_cells_east_non_edge_case
    @board.mark_sides_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['E'] == @board.board['(5, 6)']
  end
end
