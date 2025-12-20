# frozen_string_literal: true

require_relative '../color'

class Bishop # rubocop:disable Style/Documentation
  attr_accessor :bg_color
  attr_reader :current_position, :fg_color

  using Color
  def initialize(fg_color, current_position = nil)
    @piece_unicode = "\u265D "
    @bg_color = nil
    @fg_color = fg_color
    @current_position = current_position
  end

  def to_s
    @piece_unicode.bg_color(@bg_color).fg_color(@fg_color)
  end

  def movement
    {
      up_right_diagonal_moves: up_right_diagonal_moves(@current_position),
      down_right_diagonal_moves: down_right_diagonal_moves(@current_position),
      up_left_diagonal_moves: up_left_diagonal_moves(@current_position),
      down_left_diagonal_moves: down_left_diagonal_moves(@current_position)
    }
  end

  def update_current_position(position)
    @current_position = position
  end

  private

  def up_right_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8') || current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def down_right_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1') || current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def up_left_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8') || current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def down_left_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1') || current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end
end

# bishop = Bishop.new(:black, 'c1')
# p bishop.movement
