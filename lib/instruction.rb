# frozen_string_literal: true

module GameInstruction # rubocop:disable Style/Documentation
  def enter_name_message(player)
    print "#{player} enter your name before proceeding in the game!:  "
  end
  
  def choose_piece_message(name)
    puts "#{name}: Choose a piece you  wish to move"
  end

  def select_sqr_to_move
    puts 'Cool, now select a square where you would like to move your piece'
  end
end
