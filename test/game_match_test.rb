# frozen_string_literal: true

require_relative '../lib/game_match'
require_relative '../lib/board'
require 'test/unit'

class BoardBlockTest < Test::Unit::TestCase
  def test_flag_once
    board = Board.new(8, 8, 0.5)
    board.populate_blocks
    game = GameMatch.new(board)
    game.play_turn('flag 1 1')
    assert_true board.board["(0, 0)"].flagged 
  end
end