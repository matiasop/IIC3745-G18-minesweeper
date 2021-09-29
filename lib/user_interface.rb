# frozen_string_literal: true

# Clase estática
class UserInterface
  # Receive parameters as ARGV, processes it and send it as output
  def self.initial_choices(args)
    { 'n_rows' => [[20, args[0].to_i].min, 8].max, 'n_cols' => [[20, args[1].to_i].min, 8].max,
      'bomb_spawn_rate' => [[1.0, args[2].to_f].min, 0.0].max }
  end

  def self.show_board(board)
    puts
    board.print_ingame_board
    puts
  end

  def self.show_results(board, win)
    puts "\nA continuación se muestra el tablero completamente descubierto\n\n"
    board.print_hidden_board
    puts
    if win
      puts '¡Felicidades! ¡Has ganado!'
    else
      puts '¡Qué pena! Has escogido una bomba. Inténtalo de nuevo.'
    end
    puts
  end

  def self.show_instructions
    puts "Introduzca su acción junto a los dos números correspondientes a la fila y a la columna, respectivamente, \
respetando el formato:"
    puts '<action> <row> <column>'
    puts 'Números mayores al tamaño del tablero serán truncados al valor máximo respectivo de fila o columna'
    puts
  end

  def self.receive_command(player_choice)
    show_instructions
    player_choice = player_choice == '' ? $stdin.gets.chomp.split : player_choice.chomp.split
    if player_choice[0] == 'exit'
      puts '¡Gracias por jugar!'
      exit
    end
    get_action(player_choice)
  end

  def self.get_action(player_choice)
    if valid_int(player_choice[1]).nil? || valid_int(player_choice[2]).nil?
      return { 'action' => player_choice[0], 'row' => -1, 'col' => -1 }
    end

    { 'action' => player_choice[0], 'row' => player_choice[1].to_i - 1, 'col' => player_choice[2].to_i - 1 }
  end

  def self.valid_int(str)
    str =~ /^\d+$/
  end

  def self.invalid_coordinates
    puts 'Pusiste coordenadas inválidas.'
    show_instructions
  end

  def self.invalid_action
    puts 'Pusiste una acción invalida.'
    show_instructions
  end
end
