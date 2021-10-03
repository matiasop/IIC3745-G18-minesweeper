# frozen_string_literal: true

require 'optparse'
require_relative 'user_interface'
require_relative 'board'
require_relative 'game_match'

user_choices = UserInterface.initial_choices(ARGV)
board = Board.new(user_choices['n_rows'], user_choices['n_cols'], user_choices['bomb_spawn_rate'])
# board = Board.new(12, 12, 0.1)
game = GameMatch.new(board)
game.do_match
