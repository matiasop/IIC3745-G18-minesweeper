# frozen_string_literal: true

require_relative '../lib/board'
require 'test/unit'

# Class to Test marking diagonal neighbors in board
class MarkDiagonalCellsTest < Test::Unit::TestCase
  def setup
    @board = Board.new(8, 8, 0)
    @board.populate_blocks
  end

  def test_mark_up_diagonal_cells_nw_top_row
    @board.mark_up_diagonal_cells_contiguous(0, 0)
    assert_true @board.board['(0, 0)'].contiguous['NW'].nil?
  end

  def test_mark_up_diagonal_cells_ne_top_row
    @board.mark_up_diagonal_cells_contiguous(0, 0)
    assert_true @board.board['(0, 0)'].contiguous['NE'].nil?
  end

  def test_mark_up_diagonal_cells_nw_left_col
    @board.mark_up_diagonal_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['NW'].nil?
  end

  def test_mark_up_diagonal_cells_ne_left_col
    @board.mark_up_diagonal_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['NE'] == @board.board['(4, 1)']
  end

  def test_mark_up_diagonal_cells_nw_right_col
    @board.mark_up_diagonal_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['NW'] == @board.board['(4, 6)']
  end

  def test_mark_up_diagonal_cells_ne_right_col
    @board.mark_up_diagonal_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['NE'].nil?
  end

  def test_mark_up_diagonal_cells_nw_non_edge_case
    @board.mark_up_diagonal_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['NW'] == @board.board['(4, 4)']
  end

  def test_mark_up_diagonal_cells_ne_non_edge_case
    @board.mark_up_diagonal_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['NE'] == @board.board['(4, 6)']
  end

  ## Check down diagonals
  def test_mark_down_diagonal_cells_sw_bottom_row
    @board.mark_down_diagonal_cells_contiguous(7, 0)
    assert_true @board.board['(7, 0)'].contiguous['SW'].nil?
  end

  def test_mark_down_diagonal_cells_se_bottom_row
    @board.mark_down_diagonal_cells_contiguous(7, 0)
    assert_true @board.board['(7, 0)'].contiguous['SE'].nil?
  end

  def test_mark_down_diagonal_cells_sw_left_col
    @board.mark_down_diagonal_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['SW'].nil?
  end

  def test_mark_down_diagonal_cells_se_left_col
    @board.mark_down_diagonal_cells_contiguous(5, 0)
    assert_true @board.board['(5, 0)'].contiguous['SE'] == @board.board['(6, 1)']
  end

  def test_mark_down_diagonal_cells_sw_right_col
    @board.mark_down_diagonal_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['SW'] == @board.board['(6, 6)']
  end

  def test_mark_down_diagonal_cells_se_right_col
    @board.mark_down_diagonal_cells_contiguous(5, 7)
    assert_true @board.board['(5, 7)'].contiguous['SE'].nil?
  end

  def test_mark_down_diagonal_cells_sw_non_edge_case
    @board.mark_down_diagonal_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['SW'] == @board.board['(6, 4)']
  end

  def test_mark_down_diagonal_cells_se_non_edge_case
    @board.mark_down_diagonal_cells_contiguous(5, 5)
    assert_true @board.board['(5, 5)'].contiguous['SE'] == @board.board['(6, 6)']
  end
end
