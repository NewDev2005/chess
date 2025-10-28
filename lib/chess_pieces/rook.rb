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
end