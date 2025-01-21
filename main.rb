# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'

puts 'Welcome to Tic Tac Toe!'
Game.new.play
puts "Enter 'q' to exit, or any other key to play again."
Game.new.play until gets.chomp == 'q'
