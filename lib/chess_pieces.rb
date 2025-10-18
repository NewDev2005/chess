# frozen_string_literal: true

module Pieces
  BLACK_PIECES = {
    rook: "\u265C ",
    knight: "\u265E ",
    bishop: "\u265D ",
    queen: "\u265B ",
    king: "\u265A ",
    bishop2: "\u265D ",
    knight2: "\u265E ",
    rook2: "\u265C "
  }.freeze

  BLACK_PAWN = "\u265F "

  WHITE_PIECES = {
    rook: "\u2656 ",
    knight: "\u2658 ",
    bishop: "\u2657 ",
    queen: "\u2655 ",
    king: "\u2654 ",
    bishop2: "\u2657 ",
    knight2: "\u2658 ",
    rook2: "\u2656 "
  }.freeze

  WHITE_PAWN = "\u2659 "
end
