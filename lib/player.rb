# frozen_string_literal: true

require_relative 'instruction'

class Player # rubocop:disable Style/Documentation
  include GameInstruction
  attr_accessor :name, :color_pick
  attr_reader :select_piece, :select_sqr_to_place

  def initialize(board)
    @name = nil
    @color_pick = nil
    @select_piece = nil
    @select_sqr_to_place = nil
    @board = board
  end

  def prompt_player_to_select_piece
    @select_piece = verify_player_color_pick(check_empty_sqr(verify_input(gets.chomp)))
    check_piece_has_legal_moves
  end

  def prompt_player_to_select_sqr
    @select_sqr_to_place = gets.chomp
    return if @select_sqr_to_place == 'back'

    check_for_accurate_move
  end

  private

  def check_piece_has_legal_moves
    until selected_piece_has_legal_moves?
      no_legal_moves_message
      @select_piece = verify_player_color_pick(verify_input(gets.chomp))
    end
  end

  def selected_piece_has_legal_moves?
    piece = get_the_sqr_obj(@select_piece).piece
    legal_moves = piece.get_legal_moves(@board)
    return true if legal_moves.empty? == false

    false
  end

  def check_for_accurate_move
    until accurate_move?(@select_sqr_to_place)
      invalid_move_for_piece_message(@select_sqr_to_place)
      @select_sqr_to_place = gets.chomp
    end
  end

  def accurate_move?(move)
    piece = get_the_sqr_obj(@select_piece).piece
    valid_moves = piece.get_legal_moves(@board)
    valid_moves.include?(move)
  end

  def verify_player_color_pick(coord)
    until accurate_color_selection?(coord)
      choose_your_piece_message(coord)
      coord = verify_input(gets.chomp)
    end
    coord
  end

  def accurate_color_selection?(coord)
    piece_color = get_the_sqr_obj(coord).piece.fg_color
    piece_color == @color_pick
  end

  def get_the_sqr_obj(coord)
    @board.each do |rank, files|
      next unless rank == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          return sqr if alphabetic_coord == coord[0]
        end
      end
    end
  end

  def verify_input(input)
    invalid_coord(invalid_input(input))
  end

  def invalid_coord(coord)
    until valid_move?(coord)
      invalid_user_input_message
      coord = invalid_input(gets.chomp)
    end
    coord
  end

  def invalid_input(user_input)
    until user_input.length == 2 && user_input != ''
      invalid_input_message(user_input, 'input')
      user_input = gets.chomp
    end
    user_input
  end

  def valid_move?(move)
    if move[0].ord >= 97 && move[0].ord <= 104 && move[1].to_i >= 1 && move[1].to_i <= 8
      true
    else
      false
    end
  end

  def non_empty_sqr?(coord)
    sqr = get_the_sqr_obj(coord)
    return true if sqr.piece != '  '

    false
  end

  def check_empty_sqr(coord)
    until non_empty_sqr?(coord)
      empty_sqr_message
      coord = verify_input(gets.chomp)
    end
    coord
  end
end
