# frozen_string_literal: true

class GameFeatures # rubocop:disable Style/Documentation,Metrics/ClassLength
  def initialize
    @board = nil
    @coord = nil
    @piece_color = nil
    @marked_sqr = []
    @captured_sqr = []
  end

  def mark_valid_moves_of_selected_piece(board, coord)
    set_the_state(board, coord)
    sqr = get_the_sqr_obj(coord)
    moves = extract_movements_of_piece(sqr.piece)
    @piece_color = sqr.piece.fg_color
    identify_valid_movements_of_piece(moves)
  end

  def unmark_the_marked_sqr
    unmark_the_sqrs
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
    @marked_sqr = []
    hash.each_value do |arr|
      next if arr.empty?

      arr.each do |move|
        break if check_for_unoccupied_sqr?(get_the_sqr_obj(move)) == false

        verify_move?(move)
        check_for_captured_piece(move)
      end
    end
  end

  def iterate_through_all_moves_in_arr(arr)
    @marked_sqr = []
    return if arr.empty?

    arr.each do |coord|
      verify_move?(coord)
      check_for_captured_piece(coord)
    end
  end

  def check_for_unoccupied_sqr?(sqr)
    if sqr.piece == '  '
      true
    elsif check_if_sqr_has_a_piece?(sqr)
      false
    end
  end

  def check_if_sqr_has_a_piece?(sqr)
    pieces = [Bishop, King, Knight, Pawn, Queen, Rook]
    pieces.each do |piece|
      return true if sqr.piece.instance_of?(piece)
    end
    false
  end

  def check_for_color_difference?(piece)
    if piece.fg_color != @piece_color
      true
    elsif piece.fg_color == @piece_color
      false
    end
  end

  def verify_move?(coord)
    @board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          mark_the_empty_sqr_with_dot(sqr) if alphabetic_coord == coord[0] && check_for_unoccupied_sqr?(sqr)
        end
      end
    end
  end

  def check_for_captured_piece(coord)
    @board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          if alphabetic_coord == coord[0] && check_for_unoccupied_sqr?(sqr) == false
            highlight_captured_piece(sqr) if check_for_color_difference?(sqr.piece)
          end
        end
      end
    end
  end

  def mark_the_empty_sqr_with_dot(sqr)
    sqr.piece = " \u2981"
    @marked_sqr.push(sqr)
  end

  def highlight_captured_piece(sqr)
    sqr.color = :red
    @captured_sqr.push(sqr)
  end

  def unmark_the_sqrs
    @marked_sqr.each do |sqr|
      sqr.piece = '  '
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
