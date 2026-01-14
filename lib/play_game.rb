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
    @player1 = Player.new(board)
    @player2 = Player.new(board)
    @game_features = GameFeatures.new
    @check = Check.new(board)
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

  def register_move(player_obj, board)
    select_piece(player_obj, board)
    select_sqr_to_move_instruction
    select_sqr_to_place_move(player_obj, board)
    move_pieces(board.board, player_obj.select_piece, player_obj.select_sqr_to_place)
    board.display_board
  end

  def select_piece(player, board)
    choose_piece_message(player)
    player.prompt_player_to_select_piece
    @game_features.mark_valid_moves_of_selected_piece(board.board, player.select_piece)
    board.display_board
    @game_features.unmark_the_marked_sqr
    @game_features.print_legal_moves(board.board, player.select_piece)
  end

  def select_sqr_to_place_move(player, board)
    player.prompt_player_to_select_sqr
    until player.select_sqr_to_place != 'back'
      select_piece(player, board)
      select_sqr_to_move_instruction
      player.prompt_player_to_select_sqr
    end
  end

  def prompt_user_to_escape_check(player)
    cloned_board = Marshal.load(Marshal.dump(@board))
    until @check.in_check?(alter_color(player.color_pick), cloned_board.board) == false
      register_move_in_cloned_board(player, cloned_board)
      if @check.in_check?(alter_color(player.color_pick), cloned_board.board)
        @board.display_board
        cloned_board = Marshal.load(Marshal.dump(@board))
      end
    end
    update_original_board(@board, player)
  end

  def register_move_in_cloned_board(player, cloned_board)
    check_message
    select_piece(player, cloned_board)
    select_sqr_to_move_instruction
    select_sqr_to_place_move(player, cloned_board)
    move_pieces(cloned_board.board, player.select_piece, player.select_sqr_to_place)
  end

  def update_original_board(board, player)
    move_pieces(board.board, player.select_piece, player.select_sqr_to_place)
    board.display_board
  end

  def game_loop
    players = [@player1, @player2]
    loop do
      players.each do |player|
        if @check.in_check?(alter_color(player.color_pick), @board.board)
          prompt_user_to_escape_check(player)
          next
        end
        register_move(player, @board)
      end
    end
  end

  def alter_color(color)
    if color == :black
      :white
    else
      :black
    end
  end
end
