# frozen_string_literal: true

require_relative 'retrieve_pieces'
require_relative 'check_mate'
require_relative 'game_logic'

module Castling # rubocop:disable Style/Documentation
  include PieceRetrieval

  def king_side_castling_possible?(board, coord)
    return false unless king_in_check?(board, coord) == false && %w[e1 e8].include?(coord)

    board = board.board
    color = get_the_piece(board, coord).fg_color
    k_and_r_not_moved?(board, coord, 'kingside') && vacant_sqrs_in_kingside?(board, coord, color)
  end

  def queenside_castling_possible?(board, coord)
    return false unless king_in_check?(board, coord) == false && %w[e1 e8].include?(coord)

    board = board.board
    color = get_the_piece(board, coord).fg_color
    k_and_r_not_moved?(board, coord, 'queenside') && vacant_sqrs_in_queenside?(board, coord, color)
  end

  def move_rook_kingside(origin, target, board)
    piece = get_the_piece(board, origin)
    return unless piece.instance_of?(King) && target[0].ord - origin[0].ord == 2

    # move black rook kingside
    move_pieces(board, 'h8', 'f8') if origin.end_with?('8') && target.end_with?('8')
    # move white rook kingside
    move_pieces(board, 'h1', 'f1') if origin.end_with?('1') && target.end_with?('1')
  end

  def move_rook_queenside(origin, target, board)
    piece = get_the_piece(board, origin)
    return unless piece.instance_of?(King) && origin[0].ord - target[0].ord == 2

    move_pieces(board, 'a8', 'd8') if origin.end_with?('8') && target.end_with?('8')
    move_pieces(board, 'a1', 'd1') if origin.end_with?('1') && target.end_with?('1')
  end

  private

  def k_and_r_not_moved?(board, coord, rook_type)
    color = get_the_piece(board, coord).fg_color
    king_previously_not_moved?(board, coord) && rook_previously_not_moved?(board, rook_type, color)
  end

  def vacant_sqrs_in_kingside?(board, coord, color)
    sqrs = get_kingside_sqrs(coord)
    vacant_sqrs?(board, sqrs) && sqrs_being_attacked_by_enemy?(sqrs, board, color) == false
  end

  def vacant_sqrs_in_queenside?(board, coord, color)
    sqrs = get_queenside_sqrs(coord)
    vacant_sqrs?(board, sqrs) && sqrs_being_attacked_by_enemy?(sqrs, board, color) == false
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
    rook_coord = queenside_rook_coord(color) if rook_type == 'queenside'
    sqr = get_the_sqr(board, rook_coord)
    return false unless sqr.piece != '  ' && sqr.piece.instance_of?(Rook)

    rook = sqr.piece
    return true if rook.previous_position.nil?

    false
  end

  def kingiside_rook_coord(rook_color)
    return 'h1' if rook_color == :white

    'h8'
  end

  def queenside_rook_coord(rook_color)
    return 'a8' if rook_color == :black

    'a1'
  end

  def vacant_sqrs?(board, sqrs)
    sqrs.each do |sqr_coord|
      sqr = get_the_sqr(board, sqr_coord)
      next if sqr.piece == '  '
      return false if sqr.piece != '  '
    end
    true
  end

  def sqrs_being_attacked_by_enemy?(sqrs_coord, board, color)
    enemy_color = alter_color(color)
    enemy_pieces = retrieve_pieces(board, enemy_color)
    sqrs_coord.each do |coord|
      enemy_pieces.each do |piece|
        return true if piece.get_legal_moves(board).include?(coord)
      end
    end
    false
  end

  def get_kingside_sqrs(coord)
    sqrs = []
    sqrs.push("#{(coord[0].ord + 1).chr}#{coord[1]}")
    sqrs.push("#{(coord[0].ord + 2).chr}#{coord[1]}")
    sqrs
  end

  def get_queenside_sqrs(move)
    sqrs = []
    (1..3).each do |i|
      sqrs.push("#{(move[0].ord - i).chr}#{move[1]}")
    end
    sqrs
  end
end
