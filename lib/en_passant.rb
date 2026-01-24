# frozen_string_literal: true

module EnPassant # rubocop:disable Style/Documentation
  def en_passant(coord, board, piece_color)
    adjacent_coords = get_adjacent_coord(coord)
    enemy_pawns = enemy_pawn_on_adjacent_files(adjacent_coords, board, piece_color)
    sqr_passed_over_by_enemy_pawn(enemy_pawns, piece_color) if enemy_pawns.nil? == false
  end

  private

  def enemy_pawn_on_adjacent_files(adjacent_coords, board, piece_color)
    enemy_pawn = []
    adjacent_coords.each do |coord|
      piece = get_the_sqr_obj?(board, coord)
      next unless piece.instance_of?(Pawn) && piece.fg_color != piece_color

      color = piece.fg_color
      enemy_pawn.push(piece) if moved_two_sqrs_in_initial_move?(piece.current_position, piece.previous_position, color)
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

  def get_adjacent_coord(coord)
    arr = []
    arr.push("#{(coord[0].ord + 1).chr}#{coord[1]}")
    arr.push("#{(coord[0].ord - 1).chr}#{coord[1]}")
    arr
  end

  def get_the_sqr_obj?(board, coord)
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
end
