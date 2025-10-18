# frozen_string_literal: true

require_relative 'square'
require_relative 'chess_pieces'

class Board # rubocop:disable Style/Documentation
  attr_accessor :board

  include Pieces

  def initialize
    @board = { '8' => [], '7' => [], '6' => [], '5' => [], '4' => [], '3' => [], '2' => [], '1' => [] }
    @alphabetic_coords = %w[a b c d e f g h]
  end

  def set_pieces # rubocop:disable Metrics/CyclomaticComplexity,Metrics/AbcSize,Metrics/MethodLength,Metrics/PerceivedComplexity
    @board.each do |key, row| # rubocop:disable Metrics/BlockLength
      if key == '8'
        i = 0
        BLACK_PIECES.each_key do |piece_name|
          row.push(@alphabetic_coords[i] => Square.new(color_in_even_rank(i), BLACK_PIECES[piece_name], :black))
          i += 1
        end
      elsif key == '1'
        i = 0
        WHITE_PIECES.each_key do |piece_name|
          row.push(@alphabetic_coords[i] => Square.new(color_in_odd_rank(i), WHITE_PIECES[piece_name], :white))
          i += 1
        end
      elsif key == '7'
        (0..7).each do |i|
          row.push(@alphabetic_coords[i] => Square.new(color_in_odd_rank(i), BLACK_PAWN, :black))
        end
      elsif key == '2'
        (0..7).each do |i|
          row.push(@alphabetic_coords[i] => Square.new(color_in_even_rank(i), WHITE_PAWN, :white))
        end
      elsif %w[3 4 5 6].include?(key)
        if %w[4 6].include?(key)
          (0..7).each do |i|
            row.push(@alphabetic_coords[i] => Square.new(color_in_even_rank(i)))
          end
        elsif %w[3 5].include?(key)
          (0..7).each do |i|
            row.push(@alphabetic_coords[i] => Square.new(color_in_odd_rank(i)))
          end
        end
      end
    end
  end

  def display_board
    print_alphabetic_coords
    puts ''
    @board.each do |key, arr|
      print "#{key} "
      arr.each do |elem|
        elem.each_value do |sqr|
          print sqr.to_s
        end
      end
      print " #{key}"
      puts ''
    end
    print_alphabetic_coords
    puts ''
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

  def color_in_odd_rank(value)
    if value.odd?
      :light_color
    elsif value.even?
      :brown
    end
  end

  def color_in_even_rank(value)
    if value.odd?
      :brown
    elsif value.even?
      :light_color
    end
  end
end
