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
    up_right_diagonal_moves(@current_position)
    down_right_diagonal_moves(@current_position)
  end

  def up_right_diagonal_moves(current_position)
    current_position = split_chr_and_num(current_position)
    possible_moves = []
    loop do
      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i + 1}")
      break if possible_moves.last.end_with?('8') || possible_moves.last.start_with?('h')

      current_position = possible_moves.last
    end
    possible_moves
  end

  def down_right_diagonal_moves(current_position)
    current_position = split_chr_and_num(current_position)
    possible_moves = []
    loop do
      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i - 1}")
      break if possible_moves.last.end_with?('1') || possible_moves.last.start_with?('h')

      current_position = possible_moves.last
    end
    possible_moves
  end

  def split_chr_and_num(coord)
    coord.split('')
  end
end
