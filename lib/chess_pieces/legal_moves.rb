# frozen_string_literal: true

# retrieves the legal moves for a piece

module LegalMoves # rubocop:disable Style/Documentation
  def verify_legal_moves(board, coord, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    legal_move = nil
    board.each do |rank, files|
      next unless rank == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          legal_move = coord if alphabetic_coord == coord[0] && sqr.piece == '  '

          legal_move = coord if alphabetic_coord == coord[0] && sqr_is_occupied_by_enemy?(board, coord, color)
        end
      end
    end
    legal_move
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

  def sqr_is_occupied?(board, coord, color)
    sqr = get_the_sqr_obj(board, coord)
    return true if sqr.piece != '  ' && sqr.piece.fg_color == color

    false
  end

  def sqr_is_occupied_by_enemy?(board, coord, color)
    sqr = get_the_sqr_obj(board, coord)
    return true if sqr.piece != '  ' && sqr.piece.fg_color != color

    false
  end
end
