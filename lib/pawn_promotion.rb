# frozen_string_literal: true

require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/knight'
require_relative 'instruction'

module PawnPromotion # rubocop:disable Style/Documentation
  include GameInstruction
  def promote_pawn(board, destination_sqr)
    return unless destination_sqr.end_with?('8') || destination_sqr.end_with?('1')

    sqr = get_the_sqr_obj(board, destination_sqr)
    return unless sqr.piece.instance_of?(Pawn)

    piece_color = sqr.piece.fg_color
    position = sqr.piece.current_position
    replace_pawn_with_new_piece(piece_color, position, sqr)
  end

  private

  def replace_pawn_with_new_piece(color, position, sqr)
    player_preference = prompt_for_piece_preference
    sqr.piece = Queen.new(color, position) if player_preference == 'q'
    sqr.piece = Knight.new(color, position) if player_preference == 'k'
    sqr.piece = Bishop.new(color, position) if player_preference == 'b'
    sqr.piece = Rook.new(color, position) if player_preference == 'r'
  end

  def prompt_for_piece_preference
    valid_input = %w[q r k b]
    pawn_promotion_message
    user_input = gets.chomp.downcase
    until valid_input.include?(user_input)
      puts 'Enter the correct abbreviation of the piece'
      pretty_print
      user_input = gets.chomp.downcase
    end
    user_input
  end

  def get_the_sqr_obj(board, coord)
    board.each do |rank, files|
      next unless rank == coord[1]

      files.each do |elem|
        elem.each do |algebraic_coord, sqr|
          return sqr if algebraic_coord == coord[0]
        end
      end
    end
  end
end
