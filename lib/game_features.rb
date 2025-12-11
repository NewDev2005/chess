# frozen_string_literal: true

module GameFeatures # rubocop:disable Style/Documentation
  def mark_valid_moves_of_selected_piece(board, coord, mark)
    sqr = get_the_sqr_obj(board, coord)
    moves = get_valid_moves_of_piece(sqr.piece)
    check_for_hash_and_arr(moves, board, mark)
  end

  def unmark_the_valid_moves_of_selected_piece(board, coord, mark)
    sqr = get_the_sqr_obj(board, coord)
    moves = get_valid_moves_of_piece(sqr.piece)
    check_for_hash_and_arr(moves, board, mark)
  end

  private

  def get_valid_moves_of_piece(piece)
    piece.movement
  end

  def check_for_hash_and_arr(moves, board, mark)
    traverse_all_the_moves_in_hash(moves, board, mark) if moves.is_a?(Hash)
    traverse_all_the_moves_in_arr(moves, board, mark) if moves.is_a?(Array)
  end

  def traverse_all_the_moves_in_hash(hash, board, mark)
    hash.each_value do |arr|
      next if arr.empty?

      arr.each do |move|
        unmark_the_sqr(board, move) if mark == 'unmark'
        sqr = get_the_sqr_obj(board, move)
        break if check_for_unoccupied_sqr?(sqr) == false

        mark_the_sqr(board, move) if mark == 'mark'
      end
    end
  end

  def traverse_all_the_moves_in_arr(arr, board, mark)
    arr.each do |move|
      mark_the_sqr(board, move) if mark == 'mark'
      unmark_the_sqr(board, move) if mark == 'unmark'
    end
  end

  def check_for_unoccupied_sqr?(sqr)
    if sqr.piece == '  '
      true
    elsif sqr.piece != '  '
      false
    end
  end

  def mark_the_sqr(board, move)
    board.each do |rank_num, files|
      next unless rank_num == move[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          sqr.piece = " \u2981" if (alphabetic_coord == move[0]) && check_for_unoccupied_sqr?(sqr)
        end
      end
    end
  end

  def unmark_the_sqr(board, move)
    board.each do |rank_num, files|
      next unless rank_num == move[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          sqr.piece = '  ' if alphabetic_coord == move[0] && sqr.piece == " \u2981"
        end
      end
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
