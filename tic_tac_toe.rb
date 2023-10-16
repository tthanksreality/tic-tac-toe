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

# Initializes the board in the terminal, checks for wins, updates the moves
class Board
  def initialize
    @board = Array.new(3) { Array.new(3, '-') }
  end

  def display
    @board.each do |row|
      puts row.join(' | ')
    end
  end
end

milko = Board.new
milko.display
