# frozen_string_literal: true

require_relative 'square'
require_relative 'chess_pieces_unicode'
require_relative 'game_logic'
require_relative 'chess_pieces/all_pieces'

class Board # rubocop:disable Style/Documentation,Metrics/ClassLength
  attr_accessor :board

  include Pieces
  include GameLogic

  def initialize
    @board = { '8' => [], '7' => [], '6' => [], '5' => [], '4' => [], '3' => [], '2' => [], '1' => [] }
    @alphabetic_coords = %w[a b c d e f g h]
  end

  def set_pieces # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    @board.each do |key, row|
      if key == '8'
        create_instances_of_pieces(row, :light_color, :brown, :black)
      elsif key == '1'
        create_instances_of_pieces(row, :brown, :light_color, :white)
      elsif key == '7'
        create_instances_of_black_pawns(row, :black)
      elsif key == '2'
        create_instances_of_white_pawns(row, :white)
      elsif %w[3 4 5 6].include?(key)
        if %w[4 6].include?(key)
          create_instances_of_squares_in_even_rank(row)
        elsif %w[3 5].include?(key)
          create_instances_of_squares_in_odd_ranks(row)
        end
      end
    end
  end

  def display_board
    print_alphabetic_coords
    puts ''
    print_board_elements(@board)
    print_alphabetic_coords
    puts ''
    puts ''
  end

  private

  def create_instances_of_pieces(arr, sqr_color1, sqr_color2, piece_color) # rubocop:disable Metrics/AbcSize
    arr.push('a' => Square.new(sqr_color1, Rook.new(piece_color)))
    arr.push('b' => Square.new(sqr_color2, Knight.new(piece_color)))
    arr.push('c' => Square.new(sqr_color1, Bishop.new(piece_color)))
    arr.push('d' => Square.new(sqr_color2, Queen.new(piece_color)))
    arr.push('e' => Square.new(sqr_color1, King.new(piece_color)))
    arr.push('f' => Square.new(sqr_color2, Bishop.new(piece_color)))
    arr.push('g' => Square.new(sqr_color1, Knight.new(piece_color)))
    arr.push('h' => Square.new(sqr_color2, Rook.new(piece_color)))
  end

  def create_instances_of_black_pawns(arr, piece_color)
    num = 1
    (0..7).each do |i|
      arr.push(@alphabetic_coords[i] => Square.new(color_in_odd_rank(num),
                                                   Pawn.new(piece_color)))
      num += 1
    end
  end

  def create_instances_of_white_pawns(arr, piece_color)
    num = 1
    (0..7).each do |i|
      arr.push(@alphabetic_coords[i] => Square.new(color_in_even_rank(num), Pawn.new(piece_color)))
      num += 1
    end
  end

  def create_instances_of_squares_in_even_rank(arr)
    num = 1
    (0..7).each do |i|
      arr.push(@alphabetic_coords[i] => Square.new(color_in_even_rank(num)))
      num += 1
    end
  end

  def create_instances_of_squares_in_odd_ranks(arr)
    num = 1
    (0..7).each do |i|
      arr.push(@alphabetic_coords[i] => Square.new(color_in_odd_rank(num)))
      num += 1
    end
  end

  def print_board_elements(board)
    board.each do |key, arr|
      print "#{key} "
      arr.each do |elem|
        elem.each_value do |sqr|
          print sqr
        end
      end
      print " #{key}"
      puts ''
    end
  end

  def print_alphabetic_coords
    @alphabetic_coords.each do |letter|
      if letter == 'a'
        print "   #{letter}"
      else
        print "  #{letter}"
      end
    end
  end

  def color_in_even_rank(value)
    if value.odd?
      :light_color
    elsif value.even?
      :brown
    end
  end

  def color_in_odd_rank(value)
    if value.odd?
      :brown
    elsif value.even?
      :light_color
    end
  end
end
