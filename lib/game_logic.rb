# frozen_string_literal: true

module GameLogic # rubocop:disable Style/Documentation
  def move_pieces(board, origin, destination)
    sqr_propertities = iterate_origin_rank(board, origin)
    iterate_destination_rank(board, destination, sqr_propertities)
  end

  private

  def iterate_origin_rank(board, origin)
    sqr_propertities = nil
    board.each do |rank_num, rank|
      next unless rank_num == origin[1]

      sqr_propertities = update_origin(rank, origin[0])
    end
    sqr_propertities
  end

  def iterate_destination_rank(board, destination, sqr_propertities)
    board.each do |rank_num, rank|
      next unless rank_num == destination[1]

      update_destination(rank, destination, sqr_propertities)
    end
  end

  def update_destination(rank, destination, sqr_propertities)
    rank.each do |elem|
      elem.each do |alphabetic_coord, sqr|
        next unless alphabetic_coord == destination[0]

        sqr.piece = sqr_propertities[0]
        sqr.piece.update_current_position(destination)
      end
    end
  end

  def update_origin(rank, origin)
    origin_sqr_propertities = []
    rank.each do |elem|
      elem.each do |alphabetic_coord, sqr|
        next unless alphabetic_coord == origin

        origin_sqr_propertities.push(sqr.piece)
        sqr.piece = '  '
      end
    end
    origin_sqr_propertities
  end
end
