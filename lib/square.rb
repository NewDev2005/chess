# frozen_string_literal: true

require_relative 'color'
require_relative 'chess_pieces_unicode'
class Square # rubocop:disable Style/Documentation
  attr_accessor :piece, :piece_color

  using Color
  def initialize(color, piece = '  ')
    @color = color
    @piece = piece
    @piece_color = piece_color
  end

  def to_s
    if @piece == '  '
      @piece.bg_color(@color)
    elsif @piece != '  '
      @piece.to_s
    end
  end
end
