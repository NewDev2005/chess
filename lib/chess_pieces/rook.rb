require_relative '../color'

class Rook # rubocop:disable Style/Documentation
  using Color
  def initialize(color, current_position)
    @piece_unicode = "\u265C "
    @color = color
    @current_position = current_position
  end

  def to_s
    if @color == :black
      @piece_unicode.bg_color(@color).fg_color(@color)
    elsif @color == :white
      @piece_unicode.bg_color(@color).fg_color(@color)
    end
  end

  def movement
    {
      right_horizontal: right_horizontal(@current_position),
      left_horizontal: left_horizontal(@current_position),
      vertically_down: vertically_down(@current_position),
      vertically_up: vertically_up(@current_position)
    }
  end

  private

  def right_horizontal(current_position)
    possible_moves = []
    loop do
      break if current_position.start_with?('h')

      possible_moves.push("#{(current_position[0].ord + 1).chr}#{current_position[1]}")
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

rook = Rook.new(:black, 'd2')
puts rook.to_s
