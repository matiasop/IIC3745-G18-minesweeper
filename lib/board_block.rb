# frozen_string_literal: true

# Clase que representa cada bloque del tablero y se encarga de su lógica
class BoardBlock
  # Using cardinal coordinates
  NEIGHBORS = %w[N NE E SE S SW W NW].freeze
  attr_accessor :parent_board, :n_contiguous_bombs, :contiguous_zero_blocks, :played, :flagged, :contiguous
  attr_reader :bomb

  def initialize(parent_board, bomb)
    @parent_board = parent_board
    @bomb = bomb
    @n_contiguous_bombs = 0
    @contiguous_zero_blocks = []
    @played = false
    @flagged = false
    @contiguous = NEIGHBORS.each_with_object({}) do |key, hash|
      hash[key] = nil
    end
  end

  def count_contiguous_bombs
    @contiguous.each do |_key, value|
      @n_contiguous_bombs += 1 if !value.nil? && value.bomb
    end
  end

  def count_contiguous_zero_blocks
    @contiguous.each do |_key, value|
      @contiguous_zero_blocks.push(value) if !value.nil? && value.n_contiguous_bombs.zero?
    end
  end

  def play_block(board)
    return if @played || @flagged
    @played = true
    board.played_blocks += 1
    return unless @n_contiguous_bombs.zero?
    @contiguous.each do |_key, value|
      if !value.nil?
        value.play_block(board)
      end
    end
  end
end
