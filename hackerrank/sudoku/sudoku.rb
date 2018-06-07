#!/usr/bin/env ruby

class Array
  def uniq?
    arr = compact
    arr.uniq.size == arr.size
  end
end


class Sudoku

  SIZE = 9
  FILL = 10
  CELL_VALUES = (1..9).to_a
  QUAD_COORDS = [[0,0], [0,3], [0,6], [3,0], [3,3], [3,6], [6,0], [6,3], [6,6]]

  attr_reader :board


  def initialize(input=nil)
    @board = Array.new(SIZE) { Array.new(SIZE) }
    load_board(input)
  end


  def [](row, col)
    @board[row][col]
  end


  def []=(row, col, val)
    @board[row][col] = val
  end


  def solutions
    if solved?
      [self]
    else
      valid_moves.lazy.flat_map(&:solutions)
    end
  end


  def solved?
    board.flatten.compact.size == 81
  end


  def valid?
    rows.all?(&:uniq?)     &&
    columns.all?(&:uniq?)  &&
    quadrants.all?(&:uniq?)
  end


  def inspect
    "\n" + board.map do |row|
      row.map { |n| n ? n : '_' }.join("\s")
    end.join("\n")
  end


private


  def rows
    @board
  end


  def columns
    @board.transpose
  end


  def quadrants
    QUAD_COORDS.map { |(r,c)| board[r...r+3].map { |row| row[c...c+3] }.flatten }
  end


  # Board -> [Board...]
  #
  def valid_moves
    row, col = empty_positions.first
    valid_values(row, col).map do |val|
      move(row, col, val)
    end
  end


  def empty_positions
    empty = []
    rows.each_with_index do |row, ri|
      row.each_with_index do |cell, ci|
        empty << [ri, ci] if cell.nil?
      end
    end
    empty
  end


  def valid_values(row, col)
    quad = (row / 3 * 3) + (col / 3)
    CELL_VALUES - (rows[row] + columns[col] + quadrants[quad]).compact.uniq
  end


  def move(row, col, val)
    clone.tap do |new_sudoku|
      new_sudoku.instance_variable_set('@board', @board.map(&:clone))
      new_sudoku[row, col] = val
    end
  end


  def load_board(input)
    return unless input

    input.strip.lines.map(&:split).each_with_index do |row, ri|
      row.each_with_index do |val, ci|
        @board[ri][ci] = val.to_i == 0 ? nil : val.to_i
      end
    end
  end


  def self.generate(fill = FILL)
    begin
      board = Sudoku.new

      fill.times do
        row, col = board.send(:empty_positions).sample
        board[row, col] = board.send(:valid_values, row, col).sample
      end
    end until board.solutions.first

    puts
    board
  end

end


if STDIN.tty?
  p Sudoku.generate(ARGV[0] || 30)
else
  p Sudoku.new($stdin.read).solutions.first
end
