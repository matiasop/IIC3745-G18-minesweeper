#!/usr/bin/env ruby
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/")
require 'game_tile'
require 'minesweeper_game'
require 'game_board'
require 'minesweeper_parser'

puts "¡Bienvenido al juego Buscaminas!"

begin
  options = MinesweeperParser.new.parse(ARGV)
rescue OptionParser::MissingArgument, OptionParser::InvalidArgument
  help_msg = MinesweeperParser.new.parse(["-h"])
  puts help_msg
end

board = GameBoard.new(options.rows_cols_chance[:rows], options.rows_cols_chance[:cols], options.rows_cols_chance[:bomb_chance])
game = MinesweeperGame.new(board, options.rows_cols_chance[:rows], options.rows_cols_chance[:cols])

game.print_the_board
while !game.game_over? && !game.win? do
 game.play_the_game
end

if game.game_over?
  puts "\n A continuación se muestra el tablero completamente descubierto\n"
  game.print_ending_board
  puts "¡Qué pena! Has escogido una bomba. Inténtalo de nuevo."
elsif game.win?
  puts "\n A continuación se muestra el tablero completamente descubierto\n"
  game.print_ending_board
  puts "¡Felicidades! ¡Has ganado!"
end

