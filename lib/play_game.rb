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

  def prompt_players_name
    player_names = []
    enter_name_message('player1')
    player_names.push(@player1.prompt)
    enter_name_message('player2')
    player_names.push(@player2.prompt)
    player_names
  end

  def assign_color_to_players_randomly
    random_num = rand(0..1)
    player_names = prompt_players_name
    @player1.name = player_names[random_num]
    @player1.color_pick = :white
    player_names.each do |name|
      @player2.name = name if name != player_names[random_num]
      @player2.color_pick = :black
    end
  end

  def start
    assign_color_to_players_randomly
    loop do
      
    end
  end
end
