# frozen_string_literal: true

# Manages current board and player interactions
class Game
  attr_reader :board, :players

  def initialize
    @board = Array.new(10)

    @players = [HumanPlayer.new('one', self, 'X'), HumanPlayer.new('two', self, 'O')]
    puts "#{players[0].name} is facing off #{players[1].name}. Let the game begin!"
  end

  def print_board
    column_separator = ' | '
    row_separator = '--+---+--'

    get_position_label = lambda do |position|
      @board[position] || position.to_s
    end

    row_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    format_row = lambda do |row|
      row.map(&get_position_label).join(column_separator)
    end

    puts row_positions.map(&format_row).join("\n#{row_separator}\n")
  end
end
