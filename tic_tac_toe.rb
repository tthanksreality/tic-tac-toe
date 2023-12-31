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
      return column[0] if column.uniq.length == 1 && !column.include?('-')
    end
    nil
  end

  def check_win_diagonals
    diagonal1 = [@board[0][0], @board[1][1], @board[2][2]]
    diagonal2 = [@board[0][2], @board[1][1], @board[2][0]]

    if diagonal1.uniq.length == 1 && !diagonal1.include?('-')
      return diagonal1[0]
    elsif diagonal2.uniq.length == 1 && !diagonal2.include?('-')
      return diagonal2[0]
    end
    nil
  end

  def check_win
    check_win_row || check_column_win || check_win_diagonals
  end

  def full?
    @board.all? { |row| row.none?('-') }
  end
end

# Manages the basic game loop, holds the current player and players in general
class Game
  def initialize(player1, player2)
    @cage = Board.new
    @players = [player1, player2]
    @current_player = player1
  end

  def take_turn(player)
    puts "#{player}, it's your turn (Enter row and column): @"
    row, col = gets.chomp.split.map(&:to_i)

    return if @cage.update(row, col, player.symbol)

    puts 'Invalid move. Try again.'
    take_turn(player)
  end

  def switch_players
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def play_again?
    puts 'Wanna play again?'
    choice = gets.chomp.downcase
    if choice == 'yes'
      reset_game
      play
    else
      puts 'Thanks for your time'
    end
  end

  def reset_game
    @cage = Board.new
    @current_player = @players[0]
  end

  def play
    loop do
      @cage.display
      take_turn(@current_player)

      if @cage.check_win
        @cage.display
        puts "#{@current_player} wins!"
        break
      elsif @cage.full?
        @cage.display
        puts "It's a draw!"
        break
      end

      switch_players
    end

    play_again?
  end
end

# Main program
player1 = Player.new('Player 1', 'X')
player2 = Player.new('Player 2', 'O')

game = Game.new(player1, player2)
game.play
