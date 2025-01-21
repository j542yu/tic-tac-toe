# frozen_string_literal: true

# data for player in game
class HumanPlayer
  attr_reader :name, :marker

  def initialize(num, game, marker)
    puts "Player #{num}: who are you?"
    @name = gets.chomp
    @game = game
    @marker = marker
  end

  def to_s
    name
  end
end
