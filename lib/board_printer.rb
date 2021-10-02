# frozen_string_literal: true

# Static class that prints board
class BoardPrinter
  def self.print_ingame_cell(actual_cell)
    if actual_cell.played
      print actual_cell.n_contiguous_bombs.positive? ? "[ #{actual_cell.n_contiguous_bombs} ] " : '[ - ] '
    elsif actual_cell.flagged
      print '[|> ] '
    else
      print '[   ] '
    end
  end

  def self.print_ingame_board(board)
    board.n_rows.times do |row|
      board.n_cols.times do |col|
        actual = board.board["(#{row}, #{col})"]
        print_ingame_cell(actual)
      end
      puts
    end
  end

  def self.print_hidden_cell(actual_cell)
    if actual_cell.bomb
      print '[ * ] '
    elsif actual_cell.n_contiguous_bombs.positive?
      print "[ #{actual_cell.n_contiguous_bombs} ] "
    else
      print '[ - ] '
    end
  end

  def self.print_hidden_board(board)
    board.n_rows.times do |row|
      board.n_cols.times do |col|
        actual = board.board["(#{row}, #{col})"]
        print_hidden_cell(actual)
      end
      puts
    end
  end
end
