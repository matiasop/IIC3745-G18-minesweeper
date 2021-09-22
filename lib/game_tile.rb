class GameTile

    attr_accessor :adjacent, :adjacent_bombs, :been_played, :been_flagged, :adjacent_zeroes
  
    def initialize(board, up_left, up, up_right, left, right, down_left, down, down_right, is_bomb)
      @adjacent = {
        "up_left" => up_left,
        "up" => up,
        "up_right" => up_right,
        "left" => left,
        "right" => right,
        "down_left" => down_left,
        "down" => down,
        "down_right" => down_right
      }
      @is_bomb = is_bomb
      @adjacent_bombs = 0
      @adjacent_zeroes = []
      @been_played = false
      @been_flagged = false
      @board = board
    end
  
    def find_adjacent_bombs
      @adjacent.each do |key, value|
        begin
          if value.is_bomb?
            @adjacent_bombs += 1
          end
        rescue
        end
      end
    end
  
    def find_adjacent_zeroes
      @adjacent.each do |key, tile|
        begin  
          if tile.adjacent_bombs == 0
            @adjacent_zeroes << tile
          end
        rescue
        end
      end 
    end

    def play_adjacent_zeroes(board)
      if @adjacent_bombs > 0
        @been_played = true
        board.num_played += 1
        return
      else
        board.num_played += 1 unless !@been_played
        @been_played = true
        @adjacent.each do |key, tile|
          if !tile.nil? && !tile.been_played
            tile.been_played = true
            tile.play_adjacent_zeroes(board)
          end
        end
      end
  
    end
  
    def is_bomb?
      @is_bomb
    end
  end
  
  