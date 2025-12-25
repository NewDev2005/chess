# frozen_string_literal: true

require_relative '../color'
require_relative 'legal_moves'

class Pawn # rubocop:disable Style/Documentation
  include LegalMoves
  attr_accessor :bg_color
  attr_reader :current_position, :fg_color

  using Color
  def initialize(fg_color, current_position = nil)
    @bg_color = nil
    @fg_color = fg_color
    @piece_unicode = "\u265F "
    @current_position = current_position
    @possible_moves = []
    @legal_moves = []
  end

  def movement
    {
      opening_move: initial_move(@current_position),
      regular_move: regular_move(@current_position),
      capture_move: capture_move(@current_position)
    }
  end

  def to_s
    @piece_unicode.bg_color(@bg_color).fg_color(@fg_color)
  end

  def update_current_position(position)
    @current_position = position
  end

  def get_legal_moves(board)
    @legal_moves = []
    movement.each_value do |arr|
      next if arr.empty?

      arr.each do |coord|
        move = verify_legal_moves(board, coord, @fg_color)
        @legal_moves.push(move) if move.nil? == false
        break if sqr_is_occupied?(board, coord)
      end
    end
    @legal_moves
  end

  private

  def initial_move(current_position)
    @possible_moves = []
    if @fg_color == :white
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 2}") if current_position.end_with?('2')
    elsif @fg_color == :black
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 2}") if current_position.end_with?('7')

    end

    @possible_moves
  end

  def regular_move(current_position)
    @possible_moves = []
    if @fg_color == :white
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 1}")
    elsif @fg_color == :black
      @possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 1}")
    end
    @possible_moves
  end

  def capture_move(current_position) # rubocop:disable Metrics/AbcSize
    @possible_moves = []
    if @fg_color == :white
      @possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i + 1}")
      @possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i + 1}")
    elsif @fg_color == :black
      @possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i - 1}")
      @possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i - 1}")
    end
  end
end

# pawn = Pawn.new(:white, 'd4')

# p pawn.movement