require 'optparse'
require 'ostruct'
require 'pp'

ARGV << "-h" if ARGV.empty?

class MinesweeperParser
  def initialize
  end

  def parse(args)
    options = OpenStruct.new
    options.rows_cols_chance = {}
    options.inplace = false
    options.encoding = "utf8"
    options.transfer_type = :auto
    options.verbose = false

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: minesweeper [options]"
      
      opts.on("-r ROWS", "--rows ROWS", Integer, "Especifica el número de filas que tendrá el tablero, con valor máximo 20.") do |rows|
        if rows > 20 then rows = 20 elsif rows < 1 then rows = 1 end
        options.rows_cols_chance[:rows] = rows
      end

      opts.on("-c COLUMNS", "--columns COLUMNS", Integer, "Especifica el número de columnas que tendrá el tablero, con valor máximo 20.") do |cols|
        if cols > 20 then cols = 20 elsif cols < 1 then cols = 1 end
        options.rows_cols_chance[:cols] = cols
      end

      opts.on("-f BOMB_CHANCE", "--frequency BOMB_CHANCE", Float, "Especifica la frecuencia con que las bombas aparecerán en el tablero. Debe de ser un decimal perteneciente al intervalo [0, 1].") do |chance|
        if chance > 1.0 then chance = 1.0 elsif chance < 0.0 then chance = 0.0 end
        options.rows_cols_chance[:bomb_chance] = chance
      end
      
      opts.on_tail("-h", "--help", "Muestra este mensaje de ayuda.") do 
        puts opts
        exit
      end

       
    end

    opt_parser.parse!(args)
    options
  end
end

