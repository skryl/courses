class MyPiece < Piece

# add new pieces

  All_My_Pieces = All_Pieces + 
    [ rotations([[0, 0], [-1, 0], [1, 0], [0, -1], [-1, -1]]),
      rotations([[0, 0], [1, 0], [0, -1]]), 
      rotations([[0, 0], [-1, 0], [-2, 0], [1, 0], [2, 0]]) ]

  Cheat_Piece = [[[0,0]]]

  # choosing next piece based on cheat flag
  #
  def self.next_piece(board)
    board.cheating? ? 
      MyPiece.new(Cheat_Piece, board) :
      MyPiece.new(All_My_Pieces.sample, board)
  end

end


class MyBoard < Board

  # overwriting Piece with MyPiece and init cheat flag
  #
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat_flag = false
  end

  # overwriting Piece with MyPiece and resetting cheat flag
  #
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @cheat_flag = false
    @current_pos = nil
  end

  # should store an appropriate number of block locations (depends on piece size)
  #
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size-1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

# flipping

  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

# cheating

  def cheat!    
    unless @score < 100 || @cheat_flag 
      @score -= 100
      @cheat_flag = true 
    end
  end

  def cheating? 
    @cheat_flag 
  end

end


class MyTetris < Tetris

# overwriting to use MyBoard

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

# adding new key bindings

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180}) 
    @root.bind('c', proc {@board.cheat!}) 
  end

end
