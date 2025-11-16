# frozen_string_literal: true

require_relative '../color'

class Pawn # rubocop:disable Style/Documentation
  attr_accessor :bg_color
  attr_reader :current_position

  using Color
  def initialize(fg_color, current_position = nil)
    @bg_color = nil
    @fg_color = fg_color
    @piece_unicode = "\u265F "
    @current_position = current_position
    @possible_moves = []
  end

  def movement
    {
      opening_move: initial_move(@current_position),
      regular_move: regular_move(@current_position)
    }
  end

  def to_s
    @piece_unicode.bg_color(@bg_color).fg_color(@fg_color)
  end

  def update_current_position(position)
    @current_position = position
  end

  private

  def initial_move(current_position)
    @possible_moves = []
    if @color == :white
      return unless current_position.end_with?('2') || current_position.end_with?('7')

      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 2}")
    elsif @color == :black
      return unless current_position.end_with?('7') || current_position.end_with?('2')

      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 2}")
    end
  end

  def regular_move(current_position)
    @possible_moves = []
    if @color == :white
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 1}")
    elsif @color == :black
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 1}")
    end
  end
end
