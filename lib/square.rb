# frozen_string_literal: true

require_relative 'color'
require_relative 'chess_pieces_unicode'
class Square # rubocop:disable Style/Documentation
  attr_accessor :piece, :color

  using Color
  def initialize(color, piece = '  ')
    @color = color
    @piece = piece
  end

  def to_s
    if @piece == '  '
      @piece.bg_color(@color)
    elsif @piece != '  ' && @piece != " \u2981"
      @piece.bg_color = @color
      @piece.to_s
    elsif @piece == " \u2981"
      @piece.bg_color(@color).fg_color(:black)
    end
  end
end
