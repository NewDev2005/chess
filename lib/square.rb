# frozen_string_literal: true

require_relative 'color'

class Square # rubocop:disable Style/Documentation
  using Color
  def initialize(color, piece = '', piece_color = nil)
    @color = color
    @piece = piece
    @piece_color = piece_color
  end

  def to_s
    if @piece == ''
      @piece.bg_color(@color)
    elsif @piece != ''
      @piece.bg_color(@color).fg_color(@piece_color)
    end
  end
end


puts Square.new(:light_color).to_s
# puts sqr.to_s
