# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'instruction'
require_relative 'game_logic'
require_relative 'game_features'

class PlayGame # rubocop:disable Style/Documentation
  include GameInstruction
  include GameLogic
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new
    @player2 = Player.new
    @game_features = GameFeatures.new
  end

  def prompt_players_name
    player_names = []
    enter_name_message('player1')
    player_names.push(@player1.prompt)
    enter_name_message('player2')
    player_names.push(@player2.prompt)
    player_names
  end

  def assign_color_of_the_pieces_to_players_randomly
    random_num = rand(0..1)
    player_names = prompt_players_name
    @player1.name = player_names[random_num]
    @player1.color_pick = :white
    player_names.each do |name|
      @player2.name = name if name != player_names[random_num]
      @player2.color_pick = :black
    end
  end

  def register_move(player_obj)
    choose_piece_message(player_obj.name)
    # player_obj.select_piece = player_obj.prompt # extract this line into a method
    select_piece(player_obj)
    select_sqr_to_move
    player_obj.select_sqr_to_place = player_obj.prompt
    move_pieces(@board.board, player_obj.select_piece, player_obj.select_sqr_to_place)
    @board.display_board
  end

  def select_piece(player)
    player.select_piece = player.prompt
    @game_features.mark_valid_moves_of_selected_piece(@board.board, player.select_piece)
    @board.display_board
    # unmark_the_valid_moves_of_selected_piece(@board.board, player.select_piece, 'unmark')
  end

  def game_loop
    loop do
      register_move(@player1)
      register_move(@player2)
    end
  end

  def start
    assign_color_of_the_pieces_to_players_randomly
    @board.create_board
    @board.display_board
    game_loop
  end
end
