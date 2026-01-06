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
    pawn_movement = movement
    pawn_movement.each do |key, arr|
      next if arr.empty?

      push_legal_capture_move(board, arr) if key == :capture_move
      check_opening_move(board, pawn_movement[:opening_move], pawn_movement[:regular_move]) if key == :opening_move
      push_legal_move(board, arr) if key == :regular_move
    end
    @legal_moves
  end

  private

  def initial_move(current_position)
    possible_moves = []
    if @fg_color == :white
      possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 2}") if current_position.end_with?('2')
    elsif @fg_color == :black
      possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 2}") if current_position.end_with?('7')

    end
    verify_valid_coord(possible_moves)
  end

  def regular_move(current_position)
    possible_moves = []
    if @fg_color == :white
      possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 1}")
    elsif @fg_color == :black
      possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 1}")
    end
    verify_valid_coord(possible_moves)
  end

  def capture_move(current_position) # rubocop:disable Metrics/AbcSize
    possible_moves = []
    if @fg_color == :white
      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i + 1}")
      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i + 1}")
    elsif @fg_color == :black
      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i - 1}")
      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i - 1}")
    end
    verify_valid_coord(possible_moves)
  end

  def valid_coord?(move)
    return if move.length > 2

    if move[0].ord >= 97 && move[0].ord <= 104 && move[1].to_i >= 1 && move[1].to_i <= 8
      true
    else
      false
    end
  end

  def verify_valid_coord(arr)
    valid_coords = []
    arr.each do |coord|
      valid_coords.push(coord) if valid_coord?(coord)
    end
    valid_coords
  end

  def push_legal_capture_move(board, arr)
    arr.each do |coord|
      sqr = get_the_sqr_obj(board, coord)
      @legal_moves.push(sqr.piece.current_position) if sqr.piece != '  ' && sqr.piece.fg_color != fg_color
    end
  end

  def push_legal_move(board, list)
    list.each do |coord|
      break if next_sqr_is_blocked?(board, coord)

      move = verify_legal_moves(board, coord, @fg_color)
      @legal_moves.push(move) if move.nil? == false
    end
  end

  def check_opening_move(board, opening_move, regular_move)
    regular_move_sqr = get_the_sqr_obj(board, regular_move[0])
    return if regular_move_sqr.piece != '  '

    push_legal_move(board, opening_move)
  end
end

# pawn = Pawn.new(:white, 'c8')

# p pawn.movement