# frozen_string_literal: true

require_relative 'board_block'
# Board initialized board and applies moves to blocks
class Board
  TEST_BOMBS = [[0, 0], [1, 1], [2, 2], [2, 3]].freeze
  attr_accessor :win_condition, :played_blocks
  attr_reader :n_rows, :n_cols, :board, :bomb_spawn_rate

  def initialize(n_rows, n_cols, bomb_spawn_rate)
    @board = {}
    @n_rows = n_rows
    @n_cols = n_cols
    @played_blocks = 0
    @win_condition = 0
    @bomb_spawn_rate = bomb_spawn_rate
  end

  def populate_blocks
    total_bombs = 0
    @n_rows.times do |row|
      @n_cols.times do |col|
        total_bombs += block_and_bomb_spawn(row, col)
      end
    end
    @win_condition = (n_rows * n_cols) - total_bombs
  end

  def controlled_populate_blocks
    @win_condition = (n_rows * n_cols) - TEST_BOMBS.length
    @n_rows.times do |row|
      @n_cols.times do |col|
        @board["(#{row}, #{col})"] = if TEST_BOMBS.include? [row, col]
                                       BoardBlock.new(self, true)
                                     else
                                       BoardBlock.new(self, false)
                                     end
      end
    end
  end

  def block_and_bomb_spawn(row, col)
    # Initializes block and returns 1 if new bomb has been planted
    new_bomb = 0
    if rand(0.0..1.0) < @bomb_spawn_rate
      @board["(#{row}, #{col})"] = BoardBlock.new(self, true)
      new_bomb += 1
    else
      @board["(#{row}, #{col})"] = BoardBlock.new(self, false)
    end
    new_bomb
  end

  def mark_contiguous
    @n_rows.times do |row|
      @n_cols.times do |col|
        mark_up_and_down_cells_contiguous(row, col)
        mark_sides_cells_contiguous(row, col)
        mark_up_diagonal_cells_contiguous(row, col)
        mark_down_diagonal_cells_contiguous(row, col)
      end
    end
  end

  def mark_up_diagonal_cells_contiguous(row, col)
    return unless row.positive?

    @board["(#{row}, #{col})"].contiguous['NW'] = @board["(#{row - 1}, #{col - 1})"] if col.positive?
    @board["(#{row}, #{col})"].contiguous['NE'] = @board["(#{row - 1}, #{col + 1})"] if col < @n_cols - 1
  end

  def mark_down_diagonal_cells_contiguous(row, col)
    return unless row < @n_rows - 1

    @board["(#{row}, #{col})"].contiguous['SW'] = @board["(#{row + 1}, #{col - 1})"] if col.positive?
    @board["(#{row}, #{col})"].contiguous['SE'] = @board["(#{row + 1}, #{col + 1})"] if col < @n_cols - 1
  end

  def mark_up_and_down_cells_contiguous(row, col)
    @board["(#{row}, #{col})"].contiguous['N'] = @board["(#{row - 1}, #{col})"] if row.positive?
    @board["(#{row}, #{col})"].contiguous['S'] = @board["(#{row + 1}, #{col})"] if row < @n_rows - 1
  end

  def mark_sides_cells_contiguous(row, col)
    @board["(#{row}, #{col})"].contiguous['W'] = @board["(#{row}, #{col - 1})"] if col.positive?
    @board["(#{row}, #{col})"].contiguous['E'] = @board["(#{row}, #{col + 1})"] if col < @n_cols - 1
  end

  def do_blocks_counting
    @board.each do |_key, value|
      value.count_contiguous_bombs
      value.count_contiguous_zero_blocks
    end
  end

  def apply_action_to_block(action, row, col)
    actual = @board["(#{row}, #{col})"]
    if action == 'flag'
      actual.flagged = !actual.flagged
    else
      return false if actual.bomb

      actual.play_block(self)
    end
    true
  end
end
