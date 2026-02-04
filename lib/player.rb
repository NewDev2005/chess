# frozen_string_literal: true

require_relative 'instruction'

class Player # rubocop:disable Style/Documentation
  include GameInstruction
  attr_accessor :name, :color_pick
  attr_reader :select_piece, :select_sqr_to_place

  def initialize(board)
    @name = nil
    @color_pick = nil
    @board_obj = board
    @select_piece = nil
    @select_sqr_to_place = nil
    @board = board.board
  end

  def prompt_player_to_select_piece
    input = gets.chomp
    return input if input == 'exit'

    input = verify_input(input)
    return input if input == 'exit'

    input = check_empty_sqr(input)
    @select_piece = verify_player_color_pick(input)
    check_piece_has_legal_moves
  end

  def prompt_player_to_select_sqr
    @select_sqr_to_place = gets.chomp
    return 'exit' if @select_sqr_to_place == 'exit'
    return if @select_sqr_to_place == 'back'

    move = check_for_accurate_move
    'exit' if move == 'exit'
  end

  private

  def check_piece_has_legal_moves
    until selected_piece_has_legal_moves?
      no_legal_moves_message
      @select_piece = verify_player_color_pick(verify_input(gets.chomp))
    end
    'exit' if @select_piece == 'exit'
  end

  def selected_piece_has_legal_moves?
    return 'exit' if @select_piece == 'exit'

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
    'exit' if @select_sqr_to_place == 'exit'
  end

  def accurate_move?(move)
    return 'exit' if @select_sqr_to_place == 'exit'

    piece = get_the_sqr_obj(@select_piece).piece
    valid_moves = piece.get_legal_moves(@board)
    if piece.instance_of?(King) && piece.legal_castling_moves(@board_obj).empty? == false
      piece.legal_castling_moves(@board_obj).each do |move|
        valid_moves.push(move)
      end
    end
    valid_moves.include?(move)
  end

  def verify_player_color_pick(coord)
    return 'exit' if coord == 'exit'

    until accurate_color_selection?(coord)
      return 'exit' if coord == 'exit'

      choose_your_piece_message(coord)
      coord = verify_input(gets.chomp)
    end
    coord
  end

  def accurate_color_selection?(coord)
    return 'exit' if coord == 'exit'

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
    input = invalid_input(input)
    return 'exit' if input == 'exit'

    invalid_coord(input)
  end

  def invalid_coord(coord)
    return 'exit' if coord == 'exit'

    until valid_move?(coord)
      return 'exit' if coord == 'exit'

      invalid_user_input_message
      coord = invalid_input(gets.chomp)
    end
    coord
  end

  def invalid_input(user_input)
    return 'exit' if user_input == 'exit'

    until user_input.length == 2 && user_input != ''
      return 'exit' if user_input == 'exit'

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
    return 'exit' if coord == 'exit'

    sqr = get_the_sqr_obj(coord)
    return true if sqr.piece != '  '

    false
  end

  def check_empty_sqr(coord)
    until non_empty_sqr?(coord)
      empty_sqr_message
      coord = verify_input(gets.chomp)
    end
    return 'exit' if coord == 'exit'

    coord
  end
end
