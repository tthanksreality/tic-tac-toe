# frozen_string_literal: true

## Creates the player object, holding the symbol they selected and their corresponding name (Player1, Player2)
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
