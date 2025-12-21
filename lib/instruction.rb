# frozen_string_literal: true

require_relative 'color'

module GameInstruction # rubocop:disable Style/Documentation
  using Color
  def enter_name_message(player)
    print "#{player} enter your name before proceeding in the game!:  "
  end

  def choose_piece_message(player_obj)
    print player_obj.name.to_s.fg_color(:yellow)
    print ': Choose a piece you  wish to move'.fg_color(:blue)
    print "\n"
    print "\u265E ".fg_color(player_obj.color_pick)
    print '>> '
  end

  def select_sqr_to_move_instruction
    puts 'select a square where you would like to move your piece'.fg_color(:blue)
    print '>> '
  end

  def invalid_move_for_piece_message(move)
    print 'Sorry but '.fg_color(:blue)
    print move.to_s.fg_color(:red)
    print ' is not a possible move. Kindly try a different move'.fg_color(:blue)
    puts "\n"
    print '>> '
  end
end
