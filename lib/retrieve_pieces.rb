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
end
