# frozen_string_literal: true

class Queen # rubocop:disable Style/Documentation
  def initialize(color, current_position)
    @color = color
    @current_position = current_position
  end

  def movement
    {
      up_left_diagonal_moves: up_left_diagonal_moves(@current_position),
      down_right_diagonal_moves: down_right_diagonal_moves(@current_position),
      up_right_diagonal_moves: up_right_diagonal_moves(@current_position),
      down_left_diagonal_moves: down_left_diagonal_moves(@current_position),
      right_horizontal: right_horizontal(@current_position),
      left_horizontal: left_horizontal(@current_position),
      vertically_down: vertically_down(@current_position),
      vertically_up: vertically_up(@current_position)
    }
  end

  private

  def up_right_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8') || current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def down_right_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1') || current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def up_left_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8') || current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def down_left_diagonal_moves(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1') || current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def left_horizontal(current_position)
    possible_moves = []
    loop do
      break if current_position.start_with?('a')

      possible_moves.push("#{(current_position[0].ord - 1).chr}#{current_position[1]}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def right_horizontal(current_position)
    possible_moves = []
    loop do
      break if current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1]}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def vertically_up(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('8')

      possible_moves.push("#{current_position[0]}#{current_position[1].to_i + 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end

  def vertically_down(current_position)
    possible_moves = []
    loop do
      break if current_position.end_with?('1')

      possible_moves.push("#{current_position[0]}#{current_position[1].to_i - 1}")
      current_position = possible_moves.last
    end
    possible_moves
  end
end
