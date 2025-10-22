# frozen_string_literal: true

class Player # rubocop:disable Style/Documentation
  attr_accessor :name, :color_pick, :select_piece, :select_sqr_to_place

  def initialize
    @name = nil
    @color_pick = nil
    @select_piece = nil
    @select_sqr_to_place = nil
  end

  def prompt
    gets.chomp
  end
end
