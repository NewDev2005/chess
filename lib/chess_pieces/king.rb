class King
  def initialize(color, current_position)
    @color = color
    @piece_unicode = "\u265A "
    @current_position = current_position
    @possible_moves = []
  end

  def to_s
    if @color == :black
      @piece_unicode.bg_color(@color).fg_color(@color)
    elsif @color == :white
      @piece_unicode.bg_color(@color).fg_color(@color)
    end
  end

  def movement
    eleminate_nil_values(adjacent_movement(@current_position))
  end

  private

  def adjacent_movement(current_position) # rubocop:disable Metrics/AbcSize
    @possible_moves = []
    push_valid_move("#{(current_position[0].ord + 1).chr}#{current_position[1]}")
    push_valid_move("#{(current_position[0].ord - 1).chr}#{current_position[1]}")
    push_valid_move("#{current_position[0]}#{current_position[1].to_i + 1}")
    push_valid_move("#{current_position[0]}#{current_position[1].to_i - 1}")
    check_nil(@possible_moves[0])
    check_nil(@possible_moves[1])
    @possible_moves
  end

  def check_nil(move)
    return if move.nil?

    push_valid_move("#{move[0]}#{move[1].to_i + 1}")
    push_valid_move("#{move[0]}#{move[1].to_i - 1}")
  end

  def eleminate_nil_values(arr)
    non_nil = []
    arr.each do |elem|
      next if elem.nil?

      non_nil.push(elem)
    end
    non_nil
  end

  def push_valid_move(move)
    if valid_move?(move)
      @possible_moves.push(move)
    else
      @possible_moves.push(nil)
    end
  end

  def valid_move?(move)
    if move[0].ord >= 97 && move[0].ord <= 104 && move[1].to_i >= 1 && move[1].to_i <= 8
      true
    else
      false
    end
  end
end
