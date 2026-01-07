# frozen_string_literal: true

require_relative 'retrieve_pieces'

class Check # rubocop:disable Style/Documentation
  include PieceRetrieval
  def initialize(board)
    @pieces = nil
    @board = board.board
    @opponent_color = nil
  end

  def in_check?(opponent_color)
    @opponent_color = opponent_color
    @pieces = retrieve_pieces(@board, opponent_color)
    iterate_through_pieces(@pieces)
  end

  def iterate_through_pieces(pieces)
    pieces.each do |piece|
      next unless piece.get_legal_moves(@board).empty? == false

      found_king?(piece.get_legal_moves(@board)) # break once the opponent king is found!
    end
  end

  def found_king?(legal_moves)
    legal_moves.each do |legal_move|
      sqr = get_the_sqr_obj(@board, legal_move)
      return true if sqr.piece != '  ' && sqr.piece.instance_of?(King) && sqr.piece.fg_color == @color
    end
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
