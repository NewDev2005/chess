# frozen_string_literal: true

require_relative 'retrieve_pieces'
require_relative 'game_logic'

class Check # rubocop:disable Style/Documentation
  include PieceRetrieval
  include GameLogic

  def initialize(board)
    @board = board
    @color = nil # color of the piece delivering the check(opponent piece)
    @player_color = nil # color of the piece whose king is in check
    @number_of_check = nil
    @move_to_escape_check = 0
  end

  def in_check?(color, board)
    @number_of_check = 0
    @color = alter_color(color)
    pieces = retrieve_pieces(board, @color)
    iterate_through_pieces(pieces, board)
    return true if @number_of_check.positive?

    false
  end

  def check_mate?(color, board)
    @player_color = color
    player_pieces = retrieve_pieces(board, color)
    check_piece_legal_moves(player_pieces, board)
    return true if @move_to_escape_check.zero?

    false
  end

  # illegal_move: any move that puts one's king in check
  def illegal_move?(origin, destination)
    cloned_board = Marshal.load(Marshal.dump(@board))
    piece_color = get_the_sqr_obj(cloned_board).piece.fg_color
    move_pieces(cloned_board.board, origin, destination)
    return true if in_check?(piece_color, cloned_board.board)

    false
  end

  private

  def check_piece_legal_moves(pieces, board)
    pieces.each do |piece|
      next if piece.get_legal_moves(board).empty?

      iterate_legal_moves(piece, board)
    end
  end

  def iterate_legal_moves(piece, board)
    legal_moves = piece.get_legal_moves(board)
    legal_moves.each do |legal_move|
      @move_to_escape_check += 1 if escape_check?(piece.current_position, legal_move)
    end
  end

  def escape_check?(origin, destination)
    cloned_board = Marshal.load(Marshal.dump(@board))
    move_pieces(cloned_board.board, origin, destination)
    return true if in_check?(@player_color, cloned_board.board) == false

    false
  end

  def iterate_through_pieces(pieces, board)
    pieces.each do |piece|
      if piece.instance_of?(Pawn) && piece.legal_capture_move(board).empty? == false && found_king?(
        piece.legal_capture_move(board), board
      )
        @number_of_check += 1
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

  def alter_color(color)
    if color == :black
      :white
    else
      :black
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
