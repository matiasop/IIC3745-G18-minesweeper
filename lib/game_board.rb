require 'game_tile'

class GameBoard

  attr_accessor :rows, :cols, :board, :num_played, :win_value
  
  def initialize(rows, cols, bomb_chance)
    @board = {}
    @num_played = 0
    @win_value = rows * cols

    rows.times do |row|
      cols.times do |column|
        if rand < bomb_chance
          @board["(#{row}, #{column})"] = GameTile.new(self, nil, nil, nil, nil, nil, nil, nil, nil, true)
        else
          @board["(#{row}, #{column})"] = GameTile.new(self, nil, nil, nil, nil, nil, nil, nil, nil, false)
        end

        if column > 0
          @board["(#{row}, #{column})"].adjacent["left"] = @board["(#{row}, #{column - 1})"]
        end

        if row > 0
          @board["(#{row}, #{column})"].adjacent["up"] = @board["(#{row - 1}, #{column})"]
          @board["(#{row}, #{column})"].adjacent["up_left"] = @board["(#{row - 1}, #{column - 1})"]
          @board["(#{row}, #{column})"].adjacent["up_right"] = @board["(#{row - 1}, #{column + 1})"]
        end
      end
    end

    rows.times do |row|
      cols.times do |column|

        if column < cols - 1
          @board["(#{row}, #{column})"].adjacent["right"] = @board["(#{row}, #{column + 1})"]
        end

        if row < rows - 1
          @board["(#{row}, #{column})"].adjacent["down_left"] = @board["(#{row + 1}, #{column - 1})"]
          @board["(#{row}, #{column})"].adjacent["down"] = @board["(#{row + 1}, #{column})"]
          @board["(#{row}, #{column})"].adjacent["down_right"] = @board["(#{row + 1}, #{column + 1})"]
        end

      end
    end

    @board.each do |key, value|
      value.find_adjacent_bombs
      value.find_adjacent_zeroes
    end
  end
end
