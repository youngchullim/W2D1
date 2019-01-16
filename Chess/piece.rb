require 'byebug'

class Piece
  attr_accessor :pos
  attr_reader :color, :symbol, :board

  def initialize(pos, color, board)
    @color = color
    @board = board
    @pos = pos
  end

end

module SlidingPiece
  #Doesn't work!!!

  def slide(dir)
    curr_pos = self.pos.dup

    valid = true
    pos_moves = []
    while valid
      curr_pos[0] += dir[0]
      curr_pos[1] += dir[1]
      break unless self.board.valid_pos?(curr_pos)
      if self.board[curr_pos].is_a?(NullPiece)
        pos_moves << curr_pos.dup
      elsif self.board[curr_pos].color != self.color
        pos_moves << curr_pos.dup
        valid = false
      else
        valid = false
      end  
    end
    pos_moves
  end

  def moves
    moves_arr = []
    if self.move_dirs.include?(:diagonal)
      moves_arr += self.slide([1,1]) + self.slide([1, -1]) + self.slide([-1, 1]) + self.slide([-1, -1])
    end
    if self.move_dirs.include?(:horizontal)
      moves_arr += self.slide([0,1]) + self.slide([1,0]) + self.slide([0,-1]) + self.slide([-1,0])
    end
    moves_arr
  end


end

module SteppingPiece
  def end_points
    possible_pos = []
    curr_pos = self.pos.dup
    row, col = curr_pos
    if self.class == King
      possible_pos << [row + 1, col]
      possible_pos << [row - 1, col]
      possible_pos << [row, col + 1]
      possible_pos << [row, col - 1]
      possible_pos << [row + 1, col + 1]
      possible_pos << [row + 1, col - 1]
      possible_pos << [row - 1, col + 1]
      possible_pos << [row - 1, col - 1]
    else
      possible_pos << [row + 2, col + 1]
      possible_pos << [row + 2, col - 1]
      possible_pos << [row - 2, col + 1]
      possible_pos << [row - 2, col - 1]
      possible_pos << [row + 1, col + 2]
      possible_pos << [row + 1, col - 2]
      possible_pos << [row - 1, col + 2]
      possible_pos << [row - 1, col - 2]
    end
    possible_pos
  end

  # When using Board#in_check?, Knight#moves sometimes returns nil
  # and breaks the program.
  # If we move a pawn that affects the knight's possible moves
  def moves
    move_arr = end_points
    move_arr.select! { |pos| self.board.valid_pos?(pos)}
    move_arr.select! { |pos| self.board[pos].color != self.color}
    move_arr
  end

end
