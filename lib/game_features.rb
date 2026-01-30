# frozen_string_literal: true

class GameFeatures # rubocop:disable Style/Documentation
  def initialize(board)
    @board = board.board
    @piece_color = nil
    @marked_sqr = []
    @captured_sqr = []
  end

  def mark_valid_moves_of_selected_piece(coord)
    reset_the_state_for_instance_variables
    sqr = get_the_sqr_obj(coord)
    moves = extract_movements_of_piece(sqr.piece)
    @piece_color = sqr.piece.fg_color
    identify_valid_movements_of_piece(moves)
  end

  def unmark_the_marked_sqr
    unmark_the_sqrs
    unhighlight_captured_piece
  end

  def print_legal_moves(coord)
    piece = get_the_sqr_obj(coord).piece
    moves = piece.get_legal_moves(@board)
    p moves
  end

  private

  def identify_valid_movements_of_piece(moves)
    moves.each do |coord|
      sqr = get_the_sqr_obj(coord)
      highlight_captured_piece(sqr) if sqr.piece != '  '
      mark_the_empty_sqr_with_dot(sqr) if sqr.piece == '  '
    end
  end

  def mark_the_empty_sqr_with_dot(sqr)
    sqr.piece = " \u2981"
    @marked_sqr.push(sqr)
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

  def highlight_captured_piece(sqr)
    @captured_sqr.push({ sqr.color => sqr })
    sqr.color = :red
  end

  def unhighlight_captured_piece
    @captured_sqr.each do |hash|
      hash.each do |original_color, sqr|
        sqr.color = original_color
      end
    end
  end

  def unmark_the_sqrs
    @marked_sqr.each do |sqr|
      sqr.piece = '  '
    end
  end

  def reset_the_state_for_instance_variables
    @captured_sqr = []
    @marked_sqr = []
  end

  def extract_movements_of_piece(piece)
    legal_moves = piece.get_legal_moves(@board)
    if piece.instance_of?(King) && piece.legal_castling_moves.empty? == false
      piece.legal_castling_moves.each do |move|
        legal_moves.push(move)
      end
    end
    legal_moves
  end
end
