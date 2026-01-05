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
    print 'choose one of the above moves or type '.fg_color(:blue)
    print 'back '.fg_color(:yellow)
    print 'to re-make your choice.'.fg_color(:blue)
    pretty_print
  end

  def invalid_move_for_piece_message(move)
    print 'Sorry but '.fg_color(:blue)
    print move.to_s.fg_color(:red)
    print ' is not a possible move. Kindly choose one of the possible moves'.fg_color(:blue)
    pretty_print
  end

  def choose_your_piece_message(coord)
    print 'sorry but the piece at '.fg_color(:blue)
    print coord.to_s.fg_color(:red)
    print ' is not your piece.'.fg_color(:blue)
    pretty_print
  end

  def no_legal_moves_message
    print 'Selected piece has'.fg_color(:blue)
    print ' no legal moves '.fg_color(:red)
    print 'select another piece.'.fg_color(:blue)
    pretty_print
  end

  def invalid_input_message(input, value)
    print input.to_s.fg_color(:red)
    print " is not a valid #{value}".fg_color(:blue)
    pretty_print
  end

  def invalid_user_input_message
    print 'invalid input!'.fg_color(:red)
    pretty_print
  end

  def empty_sqr_message
    print 'That square doesnt contain any piece'.fg_color(:yellow)
    pretty_print
  end

  private

  def pretty_print
    puts "\n"
    print '>> '
  end
end
