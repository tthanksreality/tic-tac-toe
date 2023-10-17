# frozen_string_literal: true

## Holds the symbol they selected and their corresponding name (Player1, Player2)
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def to_s
    @name
  end
end

# Initializes the board in the terminal, checks for wins, updates the moves and checks if a move is valid
class Board
  def initialize
    @board = Array.new(3) { Array.new(3, '-') }
  end

  def display
    @board.each do |row|
      puts row.join(' | ')
    end
  end

  def valid?(row, col)
    row.between?(1, 3) && col.between?(1, 3) && @board[row - 1][col - 1] == '-'
  end

  def update(row, col, symbol)
    if valid?(row, col)
      @board[row - 1][col - 1] = symbol
      true
    else
      false
    end
  end

  def check_win_row
    @board.each do |row|
      row[0] if row.uniq.length == 1 && !row.include?('-')
    end
    nil
  end

  def check_column_win
    3.times do |col|
      column = @board.map { |row| row[col] }
      return column[0] if column.uniq.length == 1 && !column.include?(' ')
    end
    nil
  end

end

murtveca = Board.new
murtveca.display
p murtveca.valid?(1, 2)
murtveca.update(1, 1, 'X')
murtveca.update(1, 2, 'X')
murtveca.update(1, 3, 'X')
murtveca.display
murtveca.update(2, 1, 'X')
murtveca.update(3, 1, 'X')
murtveca.display
p murtveca.check_column_win
