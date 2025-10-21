# frozen_string_literal: true

class Player
  def initialize(name, color_pick)
    @name = name
    @color_pick = color_pick
    @select_piece = nil
    @select_sqr_to_place = nil
  end

  def make_move
    gets.chomp
  end
end
