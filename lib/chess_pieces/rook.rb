# frozen_string_literal: true

require_relative '../color'

class Rook # rubocop:disable Style/Documentation
  using Color
  def initialize(bg_color, fg_color, current_position = nil)
    @piece_unicode = "\u265C "
    @bg_color = bg_color
    @fg_color = fg_color
    @current_position = current_position
  end

  def to_s
    @piece_unicode.bg_color(@bg_color).fg_color(@fg_color)
  end

  def movement
    {
      right_horizontal: right_horizontal(@current_position),
      left_horizontal: left_horizontal(@current_position),
      vertically_down: vertically_down(@current_position),
      vertically_up: vertically_up(@current_position)
    }
  end

  private

  def right_horizontal(current_position)
    possible_moves = []
    loop do
      break if current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1]}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def left_horizontal(current_position)
    possible_moves = []
    loop do
      break if current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1]}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def vertically_up(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8')

      possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def vertically_down(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1')

      possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end
end
