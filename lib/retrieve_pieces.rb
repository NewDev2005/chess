# frozen_string_literal: true

module PieceRetrieval # rubocop:disable Style/Documentation
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
