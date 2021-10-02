# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board'
require 'test/unit'

# Class to Test actions in board-blocks
class ExampleTest < Test::Unit::TestCase
  def setup
    @board = Board.new(8, 8, 0.5)
    @board.controlled_populate_blocks
    @board.mark_contiguous
  end

  def test_do_blocks_counting_bombs
    @board.do_blocks_counting
    assert_equal(@board.board['(0, 1)'].n_contiguous_bombs, 2)
  end

  def test_do_blocks_counting_zero_blocks
    # duda de como contar los zero blocks
    @board.do_blocks_counting
    assert_equal(@board.board['(0, 1)'].contiguous_zero_blocks.length, 4)
  end
end