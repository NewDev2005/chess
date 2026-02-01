# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/play_game'

describe 'Castling' do # rubocop:disable Metrics/BlockLength
  it 'kingside castling move is available when sqrs between rook and king are vacant and king is not in check' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :white, origin: 'f1', target: 'd3')
    game.execute_move(color: :white, origin: 'g1', target: 'h3')

    king = game.get_the_piece(board, 'e1')
    legal_kingside_castling_move = king.legal_castling_moves(board_obj)

    expect(legal_kingside_castling_move).to include('g1')
  end

  it 'kingside castling not possible when the king is in check' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :black, origin: 'f7', target: 'f6')
    game.execute_move(color: :black, origin: 'g8', target: 'h6')
    game.execute_move(color: :black, origin: 'f8', target: 'd6')
    game.execute_move(color: :white, origin: 'd1', target: 'h5')

    king = game.get_the_piece(board, 'e8')
    legal_kingside_castling_move = king.legal_castling_moves(board_obj)

    expect(legal_kingside_castling_move).to_not include('g8')
  end

  it 'when the king has previously  moved castling is not possible' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :black, origin: 'f7', target: 'f6')
    game.execute_move(color: :black, origin: 'g8', target: 'h6')
    game.execute_move(color: :black, origin: 'f8', target: 'd6')
    game.execute_move(color: :black, origin: 'e8', target: 'f8')
    game.execute_move(color: :black, origin: 'f8', target: 'e8')

    king = game.get_the_piece(board, 'e8')
    legal_kingside_castling_move = king.legal_castling_moves(board_obj)

    expect(legal_kingside_castling_move).to_not include('g8')
  end

  it 'when the rook has previously moved castiling is not possible' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'e2', target: 'e4')
    game.execute_move(color: :black, origin: 'f7', target: 'f6')
    game.execute_move(color: :black, origin: 'g8', target: 'h6')
    game.execute_move(color: :black, origin: 'f8', target: 'd6')
    game.execute_move(color: :black, origin: 'h8', target: 'g8')
    game.execute_move(color: :black, origin: 'g8', target: 'h8')

    king = game.get_the_piece(board, 'e8')
    legal_kingside_castling_move = king.legal_castling_moves(board_obj)

    expect(legal_kingside_castling_move).to_not include('g8')
  end

  it 'when only one vacant sqr is present between king and rook in kingside' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'g1', target: 'h3')

    king = game.get_the_piece(board, 'e1')
    legal_kingside_castling_move = king.legal_castling_moves(board_obj)

    expect(legal_kingside_castling_move).to be_empty
  end

  it 'when one of the vacant squares is being attacked by enemy piece' do
    game = PlayGame.new
    game.board.create_board
    board = game.board.board
    board_obj = game.board

    game.execute_move(color: :white, origin: 'd2', target: 'd4')
    game.execute_move(color: :white, origin: 'c1', target: 'h6')
    game.execute_move(color: :black, origin: 'g7', target: 'g5')
    game.execute_move(color: :black, origin: 'g8', target: 'f7')
    game.execute_move(color: :black, origin: 'e7', target: 'e6')
    game.execute_move(color: :black, origin: 'f8', target: 'e7')

    king = game.get_the_piece(board, 'e1')
    legal_castling_moves = king.legal_castling_moves(board_obj)

    expect(legal_castling_moves).to be_empty
  end
end
