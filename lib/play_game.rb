require_relative 'board'
require_relative 'player'

class PlayGame # rubocop:disable Style/Documentation
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new
    @player2 = Player.new
  end

  def play 
    
  end
end
