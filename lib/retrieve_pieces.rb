# frozen_string_literal: true

# #retrieves_pieces returns all the pieces of a specific color either white or black
module PieceRetrieval
  def retrieve_pieces(board, color)
    pieces = []
    board.each_value do |files|
      files.each do |elem|
        elem.each_value do |sqr|
          pieces.push(sqr.piece) if sqr.piece != '  ' && sqr.piece.fg_color == color
        end
      end
    end
    pieces
  end

  def retrieve_opponent_pawns(board, color)
    pieces = []
    board.each_value do |files|
      files.each do |elem|
        elem.each_value do |sqr|
          pieces.push(sqr.piece) if sqr.piece != '  ' && sqr.piece.fg_color == color && sqr.piece.instance_of?(Pawn)
        end
      end
    end
    pieces
  end

  def alter_color(color)
    if color == :black
      :white
    else
      :black
    end
  end

  def get_the_sqr(board, coord)
    board.each do |rank, file|
      next unless rank == coord[1]

      file.each do |elem|
        elem.each do |algebraic_coord, sqr|
          next unless algebraic_coord == coord[0]

          return sqr
        end
      end
    end
  end

  def get_the_piece(board, coord)
    board.each do |rank, files|
      next unless rank == coord[1]

      files.each do |elem|
        elem.each do |algebraic_coord, sqr|
          next unless algebraic_coord == coord[0]

          return sqr.piece
        end
      end
    end
  end

  def assign_board_obj_to_both_king(board)
    black_king = get_the_piece(board.board, 'e8')
    white_king = get_the_piece(board.board, 'e1')
    black_king.board = board
    white_king.board = board
  end
end
