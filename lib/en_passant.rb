# frozen_string_literal: true

require_relative 'retrieve_pieces'

module EnPassant # rubocop:disable Style/Documentation
  include PieceRetrieval
  def en_passant(coord, board, piece_color)
    adjacent_coords = get_adjacent_coord(coord)
    enemy_pawns = enemy_pawn_on_adjacent_files(adjacent_coords, board, piece_color)
    sqr_passed_over_by_enemy_pawn(enemy_pawns, piece_color) if enemy_pawns.nil? == false
  end

  def enable_en_passant_capture(selected_sqr, board)
    piece = get_the_piece(board, selected_sqr)
    return unless piece.instance_of?(Pawn)

    return unless moved_two_sqrs_in_initial_move?(piece.current_position, piece.previous_position, piece.fg_color)

    piece.en_passant_capture_mode = true if piece.en_passant_capture_mode.nil?
  end

  def disable_en_passant_in_next_turn(color, board)
    opponent_pawns = retrieve_opponent_pawns(board, alter_color(color))
    opponent_pawns.each do |pawn|
      pawn.en_passant_capture_mode = false if pawn.en_passant_capture_mode == true
    end
  end

  def en_passant_capture(selected_sqr, destination_sqr, board)
    piece = get_the_piece(board, selected_sqr)
    return unless piece.instance_of?(Pawn) && diagonal_move?(selected_sqr, destination_sqr)

    sqr = get_the_sqr(board, destination_sqr)
    if sqr.piece == '  ' && piece.fg_color == :white
      coord = "#{destination_sqr[0]}#{destination_sqr[1].to_i - 1}"
      capture_piece_through_en_passant(coord, board)
    end

    if sqr.piece == '  ' && piece.fg_color == :black
      coord = "#{destination_sqr[0]}#{destination_sqr[1].to_i + 1}"
      capture_piece_through_en_passant(coord, board)
    end
  end

  private

  def capture_piece_through_en_passant(coord, board)
    sqr = get_the_sqr(board, coord)
    sqr.piece = '  ' if sqr.piece.en_passant_capture_mode == true
  end

  def diagonal_move?(first_coord, second_coord)
    if first_coord[0] != second_coord[0] && first_coord[1] != second_coord[1]
      true
    else
      false
    end
  end

  def enemy_pawn_on_adjacent_files(adjacent_coords, board, piece_color)
    enemy_pawn = []
    adjacent_coords.each do |coord|
      piece = get_the_piece(board, coord)
      next unless piece.instance_of?(Pawn) && piece.fg_color != piece_color

      color = piece.fg_color
      enemy_pawn.push(piece) if moved_two_sqrs_in_initial_move?(piece.current_position, piece.previous_position,
                                                                color) && piece.en_passant_capture_mode == true
    end
    enemy_pawn
  end

  def moved_two_sqrs_in_initial_move?(current_position, previous_position, color)
    return true if (color == :white) && white_pawn(current_position, previous_position)

    return true if (color == :black) && black_pawn(current_position, previous_position)

    false
  end

  def white_pawn(current_position, previous_position)
    if current_position[0] == previous_position[0] && current_position[1].to_i - previous_position[1].to_i == 2
      true
    else
      false
    end
  end

  def black_pawn(current_position, previous_position)
    if current_position[0] == previous_position[0] && previous_position[1].to_i - current_position[1].to_i == 2
      true
    else
      false
    end
  end

  def sqr_passed_over_by_enemy_pawn(arr, color)
    moves = []
    arr.each do |piece|
      position = piece.current_position
      moves.push("#{position[0]}#{position[1].to_i + 1}") if color == :white
      moves.push("#{position[0]}#{position[1].to_i - 1}") if color == :black
    end
    moves
  end

  def get_adjacent_coord(coord) # rubocop:disable Metrics/AbcSize
    arr = []
    arr.push("#{(coord[0].ord + 1).chr}#{coord[1]}") if valid_coord?("#{(coord[0].ord + 1).chr}#{coord[1]}")
    arr.push("#{(coord[0].ord - 1).chr}#{coord[1]}") if valid_coord?("#{(coord[0].ord - 1).chr}#{coord[1]}")
    arr
  end

  def valid_coord?(move)
    return if move.length > 2

    if move[0].ord >= 97 && move[0].ord <= 104 && move[1].to_i >= 1 && move[1].to_i <= 8
      true
    else
      false
    end
  end
end
