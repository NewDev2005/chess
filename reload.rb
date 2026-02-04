require 'yaml'
require_relative 'lib/play_game'

module Chess # rubocop:disable Style/Documentation
  def self.reload
    YAML.load_file(
      'game_state.yaml',
      permitted_classes: [self, PlayGame, Board, Square, Rook, Pawn, Bishop, Queen, King, Knight, Player, Check,GameFeatures,  Symbol], aliases: true
    )
  end
end

game = Chess.reload
game.start
