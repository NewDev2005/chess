# frozen_string_literal: true

require_relative '../color'

class Bishop # rubocop:disable Style/Documentation
  using Color
  def initialize(color, current_position)
    @piece_unicode = "\u265D "
    @color = color
    @current_position = current_position
  end

  def to_s
    if @color == :black
      @piece_unicode.bg_color(@color).fg_color(@color)
    elsif @color == :white
      @piece_unicode.bg_color(@color).fg_color(@color)
    end
  end

  def movement
    p up_right_diagonal_moves(@current_position)
    p down_right_diagonal_moves(@current_position)
    p up_left_diagonal_moves(@current_position)
    p down_left_diagonal_moves(@current_position)
  end

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

  def split_chr_and_num(coord)
    coord.split('')
  end
end

bishop = Bishop.new(:white, 'd4')
bishop.movement
