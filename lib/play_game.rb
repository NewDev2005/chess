# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'instruction'
require_relative 'game_logic'
require_relative 'game_features'
require_relative 'check'

class PlayGame # rubocop:disable Style/Documentation
  include GameInstruction
  include GameLogic
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new(@board.board)
    @player2 = Player.new(@board.board)
    @game_features = GameFeatures.new
    @check = Check.new(@board.board)
  end

  def start
    assign_color_of_the_pieces_to_players_randomly
    @board.create_board
    @board.display_board
    game_loop
  end

  private

  def prompt_players_name
    player_names = []
    enter_name_message('player1')
    player_names.push(gets.chomp)
    enter_name_message('player2')
    player_names.push(gets.chomp)
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
    choose_piece_message(player_obj)
    select_piece(player_obj)
    select_sqr_to_move_instruction
    select_sqr_to_place_move(player_obj)
    move_pieces(@board.board, player_obj.select_piece, player_obj.select_sqr_to_place)
    @board.display_board
  end

  def select_piece(player)
    player.prompt_player_to_select_piece
    @game_features.mark_valid_moves_of_selected_piece(@board.board, player.select_piece)
    @board.display_board
    @game_features.unmark_the_marked_sqr
    @game_features.print_legal_moves(@board.board, player.select_piece)
  end

  def select_sqr_to_place_move(player)
    player.prompt_player_to_select_sqr
  end

  def get_piece_color(coord)
    @board.board.each do |rank_num, files|
      next unless rank_num == coord[1]

      files.each do |elem|
        elem.each do |alphabetic_coord, sqr|
          return sqr.piece.fg_color if alphabetic_coord == coord[0]
        end
      end
    end
  end

  def game_loop
    loop do
      register_move(@player1)
      register_move(@player2)
    end
  end
end
