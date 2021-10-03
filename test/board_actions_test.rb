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

  def test_play_action_empty_position
    @board.do_blocks_counting
    @board.apply_action_to_block('play', 0, 1)
    assert_equal(@board.board['(0, 1)'].played, true)
  end

  def test_play_action_flagged_position
    @board.do_blocks_counting
    @board.apply_action_to_block('flag', 0, 1)
    @board.apply_action_to_block('play', 0, 1)
    assert_equal(@board.board['(0, 1)'].played, false)
  end

  def test_play_action_bomb_position
    @board.do_blocks_counting
    assert_equal(@board.apply_action_to_block('play', 0, 0), false)
  end

  def test_flag_action_empty_position
    @board.do_blocks_counting
    @board.apply_action_to_block('flag', 0, 1)
    assert_equal(@board.board['(0, 1)'].flagged, true)
  end

  def test_flag_action_played_position
    @board.do_blocks_counting
    @board.apply_action_to_block('play', 0, 1)
    @board.apply_action_to_block('flag', 0, 1)
    assert_equal(@board.board['(0, 1)'].flagged, false)
  end
end
