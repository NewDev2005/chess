# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'instruction'

class PlayGame # rubocop:disable Style/Documentation
  include GameInstruction
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new
    @player2 = Player.new
  end

  def set_players_name
    enter_name('player1')
    @player1.name = @player1.prompt
    enter_name('player2')
    @player2.name = @player2.prompt
  end

  def set_players_pieces_color
    @player1.color_pick = @player1.prompt
    @player2.color_pick = @player2.prompt
  end

  def play
    set_players_name
    set_players_pieces_color
  end
end
