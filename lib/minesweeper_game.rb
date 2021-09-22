class MinesweeperGame
  
    attr_accessor :board
  
    def initialize(board, rows, columns)
      @board = board
      @rows = rows
      @columns = columns
      @game_over = false
      @win = false
    end
  
    def print_the_board
      @rows.times do |row|
        @columns.times do |column|
          if !@board.board["(#{row}, #{column})"].been_played
            print "[  ] "
          elsif @board.board["(#{row}, #{column})"].been_flagged
            print "[|>] "
          else
            if @board.board["(#{row}, #{column})"].adjacent_bombs > 0 
              print "[ " + @board.board["(#{row}, #{column})"].adjacent_bombs.to_s + "] "
            else
              print "[--] "
            end
          end
        end
        puts
      end
    end
  
    def play_the_game
      puts "Introduzca su acción junto a los dos números correspondientes a la fila y a la columna, respectivamente, respetando el formato:"
      puts "<pf> <row>, <column>"
      puts "Números mayores al tamaño del tablero serán truncados al valor máximo respectivo de fila o columna"
      puts
      player_choice = gets.chomp

      if player_choice == "exit"
        puts "¡Gracias por jugar!"
        exit()
      end
  
      if /^(help|h)\z/.match(player_choice.downcase) then print_help_message end
  
      while /^([pfPF]) (\d{1,2}), (\d{1,2})\z/.match(player_choice) == nil
        puts "Introduzca su acción junto a los dos números correspondientes a la fila y a la columna, respectivamente, respetando el formato:"
        puts "<pf> <fila>, <columna>"
        puts "Números mayores al tamaño del tablero serán truncados al valor máximo respectivo de fila o columna"
        puts
        player_choice = gets.chomp

        if player_choice == "exit"
            puts "¡Gracias por jugar!"
            exit()
        end

        if /^(help|h)\z/.match(player_choice.downcase) then print_help_message end
      end
      match = /^([pfPF]) (\d{1,2}), (\d{1,2})\z/.match(player_choice)
      row = match[2].to_i
      col = match[3].to_i
  
      if row > @rows then row = @rows end
      if col > @columns then col = @columns end

      if match[1] == 'p' || match[1] == 'P'
        play_tile(row - 1, col - 1)
      elsif match[1] == 'f' || match[1] == 'F'
        flag_tile(row - 1, col - 1)
      end
      puts
      print_the_board
    end
  
    def play_tile(row, column)
      if @board.board["(#{row}, #{column})"].is_bomb?
        @game_over = true
      else
        @board.num_played += 1 unless @board.board["(#{row}, #{column})"].been_played || @board.board["(#{row}, #{column})"].adjacent_bombs == 0
        @board.board["(#{row}, #{column})"].been_played = true
        if @board.board["(#{row}, #{column})"].adjacent_bombs == 0
          @board.board["(#{row}, #{column})"].play_adjacent_zeroes(@board)
        end
        if @board.num_played == @board.win_value
          @win = true
        end
      end
      
    end
   
    def flag_tile(row, column)
      if @board.board["(#{row}, #{column})"].been_flagged
        @board.board["(#{row}, #{column})"].been_flagged = false
      else
        @board.board["(#{row}, #{column})"].been_flagged = true
        @board.num_played += 1 unless @board.board["(#{row}, #{column})"].been_played
        @board.board["(#{row}, #{column})"].been_played = true
        if @board.num_played == @board.win_value
          @win = true
        end
      end
    end
  
    def game_over?
      @game_over
    end
  
    def win?
      @win
    end
  
    def print_ending_board
      @rows.times do |row|
        @columns.times do |col|
          if @board.board["(#{row}, #{col})"].is_bomb? 
            print "[ *] " 
          else
            print "[ " + @board.board["(#{row}, #{col})"].adjacent_bombs.to_s + "] "
          end
        end
        puts
      end
    end
  
    
    private
      def print_help_message
        puts """
        Mensaje de help pendiente
        """
        print_the_board
      end
  
  
end
  
  