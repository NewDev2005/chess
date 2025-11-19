# frozen_string_literal: true

module GameFeatures # rubocop:disable Style/Documentation
  def highlight_valid_moves_of_selected_piece(board, coord)
    piece = get_the_piece_obj(board, coord)
    moves = get_valid_moves_of_piece(piece)
    check_for_hash_and_arr(moves, board)
  end

  def get_valid_moves_of_piece(piece)
    piece.movement
  end

  def check_for_hash_and_arr(moves, board)
    if moves.is_a?(Hash)
      traverse_all_the_moves_in_hash(moves, board)
    end
  end

  def traverse_all_the_moves_in_hash(hash, board)
    hash.each_value do |arr|
      next if arr.empty?

      arr.each do |move|
        traverse_the_board(board, move)
      end
    end
  end

  def check_for_unoccupied_sqr(sqr)
    if sqr.piece == '  '
      true
    elsif sqr.piece != '  '
      false
    end
  end

  def traverse_the_board(board, move)
    board.each do |rank_num, files|
      next unless rank_num == move[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          sqr.piece = " \u2981" if (alphabetic_coord == move[0]) && check_for_unoccupied_sqr(sqr)
        end
      end
    end
  end

  def get_the_piece_obj(board, coord)
    board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          return sqr.piece if alphabetic_coord == coord[0]
        end
      end
    end
  end
end
