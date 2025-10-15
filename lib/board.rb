# frozen_string_literal: true

require_relative 'square'
require_relative 'chess_pieces'

class Board 
  def initialize
    @board = { '8': [], '7': [], '6': [], '5': [], '4': [], '3': [], '2': [], '1': [] }
  end

  def set_pieces
    @board.each do |key, row|
      (1..8).each do |i|
       if key == 8
          BLACK_PIECES.each do |piece, unicode|
          row.push('a' => BLACK_PIECES[piece])
        end
       end
      end
    end
  end
end