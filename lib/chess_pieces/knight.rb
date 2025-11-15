# frozen_string_literal: true

require_relative '../color'

class Knight # rubocop:disable Style/Documentation
  using Color
  attr_reader :possible_moves
  attr_accessor :bg_color

  def initialize(fg_color, current_position = nil)
    @bg_color = nil
    @fg_color = fg_color
    @piece_unicode = "\u265E "
    @current_position = current_position
    @possible_moves = []
  end

  def movement
    get_possible_moves(@current_position)
    @possible_moves
  end

  def to_s
    @piece_unicode.bg_color(@bg_color).fg_color(@fg_color)
  end

  private

  def valid_move?(move)
    return if move.length > 2

    if move[0].ord >= 97 && move[0].ord <= 104 && move[1].to_i >= 1 && move[1].to_i <= 8
      true
    else
      false
    end
  end

  def get_possible_moves(current_position)
    double_increment(current_position, 2, 1)
    double_increment(current_position, 1, 2)
    decrement_increment(current_position, 1, 2)
    decrement_increment(current_position, 2, 1)
    increment_decrement(current_position, 2, 1)
    decrement_decrement(current_position, 1, 2)
    decrement_decrement(current_position, 2, 1)
    increment_decrement(current_position, 1, 2)
  end

  def double_increment(move, num1, num2)
    return unless valid_move?("#{(move[0].ord + num1).chr}#{move[1].to_i + num2}")

    @possible_moves.push("#{(move[0].ord + num1).chr}#{move[1].to_i + num2}")
  end

  def decrement_increment(move, num1, num2)
    return unless valid_move?("#{(move[0].ord - num1).chr}#{move[1].to_i + num2}")

    @possible_moves.push("#{(move[0].ord - num1).chr}#{move[1].to_i + num2}")
  end

  def increment_decrement(move, num1, num2)
    return unless valid_move?("#{(move[0].ord + num1).chr}#{move[1].to_i - num2}")

    @possible_moves.push("#{(move[0].ord + num1).chr}#{move[1].to_i - num2}")
  end

  def decrement_decrement(move, num1, num2)
    return unless valid_move?("#{(move[0].ord - num1).chr}#{move[1].to_i - num2}")

    @possible_moves.push("#{(move[0].ord - num1).chr}#{move[1].to_i - num2}")
  end
end
