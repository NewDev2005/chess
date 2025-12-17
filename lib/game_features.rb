# frozen_string_literal: true

class GameFeatures # rubocop:disable Style/Documentation,Metrics/ClassLength
  def initialiaze
    @board = nil
    @coord = nil
    @piece_color = nil
    @valid_moves = []
  end

  def mark_valid_moves_of_selected_piece(board, coord)
    set_the_state(board, coord)
    sqr = get_the_sqr_obj(coord)
    moves = extract_movements_of_piece(sqr.piece)
    @piece_color = sqr.piece.fg_color
    identify_valid_movements_of_piece(moves)
    traverse_all_the_valid_moves
  end

  private

  def set_the_state(board, coord)
    @board = board
    @coord = coord
  end

  def extract_movements_of_piece(piece)
    piece.movement
  end

  def check_for_arr?(moves)
    if moves.is_a?(Array)
      true
    elsif moves.is_a?(Hash)
      false
    end
  end

  def identify_valid_movements_of_piece(moves)
    iterate_through_all_moves_in_arr(moves) if check_for_arr?(moves)
    iterate_through_all_moves_in_hash(moves) if check_for_arr?(moves) == false
  end

  def iterate_through_all_moves_in_hash(hash)
    hash.each_value do |arr|
      next if arr.empty?

      arr.each do |move|
        verify_move(move)
      end
    end
  end

  def iterate_through_all_moves_in_arr(arr)
    return unless arr.empty?

    arr.each do |coord|
      verify_move(coord)
    end
  end

  def check_for_unoccupied_sqr?(sqr)
    if sqr.piece == '  '
      true
    elsif sqr.piece != '  ' && sqr.piece != " \u2981"
      false
    end
  end

  def check_for_color_difference?(piece)
    if piece.fg_color != @piece_color
      true
    elsif piece.fg_color == @piece_color
      false
    end
  end

  def check_for_captured_piece?(sqr)
    if check_for_unoccupied_sqr?(sqr) == false && check_for_color_difference?(sqr.piece)
      true
    else
      false
    end
  end

  def verify_move(coord) # rubocop:disable Metrics/CyclomaticComplexity
    @board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          p @valid_moves
          @valid_moves.push(coord) if alphabetic_coord == coord[0] && check_for_unoccupied_sqr?(sqr)
          @valid_moves.push(coord) if alphabetic_coord == coord[0] && check_for_captured_piece?(sqr)
        end
      end
    end
  end

  def mark_the_empty_sqr_with_dot(sqr)
    sqr.piece = " \u2981"
  end

  def highlight_the_piece_being_captured(sqr)
    sqr.color = :red
  end

  def traverse_all_the_valid_moves
    @valid_moves.each do |coord|
      sqr_obj = get_the_sqr_obj(coord)
      mark_the_empty_sqr_with_dot(sqr_obj) if sqr_obj.piece == '  '
      highlight_the_piece_being_captured(sqr_obj) if sqr_obj.piece != '  '
    end
  end

  def get_the_sqr_obj(coord)
    @board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          return sqr if alphabetic_coord == coord[0]
        end
      end
    end
  end
end
