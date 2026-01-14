# frozen_string_literal: true

require_relative 'retrieve_pieces'
require_relative 'game_logic'

class Check # rubocop:disable Style/Documentation
  include PieceRetrieval
  include GameLogic

  def initialize(board)
    @pieces = nil
    @board = board
    @color = nil
    @number_of_check = nil
  end

  def in_check?(color, board)
    @number_of_check = 0
    @color = color
    @pieces = retrieve_pieces(board, @color)
    iterate_through_pieces(@pieces, board)
    return true if @number_of_check.positive?

    false
  end

  # def prompt_user_to_escape_check(origin, destination)
  #   cloned_board = @board.clone
  #   move_pieces(cloned_board, origin, destination)
  # end

  private

  def iterate_through_pieces(pieces, board)
    pieces.each do |piece|
      if piece.instance_of?(Pawn) && piece.legal_capture_move(board).empty? == false
        @number_of_check += 1 if found_king?(piece.legal_capture_move(board), board)
      end

      next unless piece.get_legal_moves(board).empty? == false && piece.instance_of?(Pawn) == false

      @number_of_check += 1 if found_king?(piece.get_legal_moves(board), board)
    end
  end

  def found_king?(legal_moves, board)
    legal_moves.each do |legal_move|
      sqr = get_the_sqr_obj(board, legal_move)
      next if sqr.piece == '  '
      return true if sqr.piece != '  ' && sqr.piece.instance_of?(King) && sqr.piece.fg_color != @color
    end
    false
  end

  def get_the_sqr_obj(board, coord)
    board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          return sqr if alphabetic_coord == coord[0]
        end
      end
    end
  end
end
