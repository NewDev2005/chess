# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/play_game'

describe 'En Passant' do
  it 'allows white pawn to capture black pawn en passant' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :white, origin: 'e4', target: 'e5')

    game.execute_move(color: :black, origin: 'd7', target: 'd5')

    white_pawn = game.get_the_piece(board, 'e5')
    legal_moves = white_pawn.get_legal_moves(board)

    expect(legal_moves).to include('d6')
  end

  it 'en passant capture is lost in next turn if not executed' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :white, origin: 'e4', target: 'e5')

    game.execute_move(color: :black, origin: 'd7', target: 'd5')
    game.execute_move(color: :white, origin: 'b2', target: 'b4')

    white_pawn = game.get_the_piece(board, 'e5')
    legal_moves = white_pawn.get_legal_moves(board)

    expect(legal_moves).to_not include('d6')
  end

  it 'doesnt allow white pawn capture black pawn en passant' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :white, origin: 'e4', target: 'e5')

    game.execute_move(color: :black, origin: 'd7', target: 'd6')
    game.execute_move(color: :black, origin: 'd6', target: 'd5')

    white_pawn = game.get_the_piece(board, 'e5')
    legal_moves = white_pawn.get_legal_moves(board)

    expect(legal_moves).to_not include('d6')
  end
end
