# frozen_string_literal: true

require_relative 'retrieve_pieces'
require_relative 'check_mate'

module Castling # rubocop:disable Style/Documentation
  include PieceRetrieval

  def king_side_castling_possible?(board, coord)
    return unless king_in_check?(board, coord) == false

    board = board.board
    k_and_r_not_moved?(board, coord, 'kingside') && vacant_sqrs_in_kingside?(board, coord)
  end

  def k_and_r_not_moved?(board, coord, rook_type)
    color = get_the_piece(board, coord).fg_color
    king_previously_not_moved?(board, coord) && rook_previously_not_moved?(board, rook_type, color)
  end

  def king_in_check?(board, coord)
    king = get_the_piece(board.board, coord)
    king_color = king.fg_color
    check = Check.new(board)
    check.in_check?(king_color, board.board)
  end

  def king_previously_not_moved?(board, coord)
    king = get_the_piece(board, coord)
    return true if king.previous_position.nil?

    false
  end

  def rook_previously_not_moved?(board, rook_type, color)
    rook_coord = kingiside_rook_coord(color) if rook_type == 'kingside'
    sqr = get_the_sqr(board, rook_coord)
    return false unless sqr.piece != '  ' && sqr.piece.instance_of?(Rook)

    rook = sqr.piece
    return true if rook.previous_position.nil?

    false
  end

  def kingiside_rook_coord(rook_color)
    return 'hi' if rook_color == :white

    'h8'
  end

  def vacant_sqrs_in_kingside?(board, coord)
    sqrs = get_kingside_sqrs(coord)
    vacant_sqrs?(board, sqrs)
  end

  def vacant_sqrs?(board, sqrs)
    sqrs.each do |sqr_coord|
      sqr = get_the_sqr(board, sqr_coord)
      next if sqr.piece == '  '
      return false if sqr.piece != '  '
    end
    true
  end

  def get_kingside_sqrs(coord)
    sqrs = []
    sqrs.push("#{(coord[0].ord + 1).chr}#{coord[1]}")
    sqrs.push("#{(coord[0].ord + 2).chr}#{coord[1]}")
    sqrs
  end
end
