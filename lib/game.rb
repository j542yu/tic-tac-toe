# frozen_string_literal: true

# Manages current board and player interactions
class Game
  attr_reader :board, :players

  WINNING_COMBINATIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

  def initialize
    @board = Array.new(10)

    @players = [HumanPlayer.new('one', self, 'X'), HumanPlayer.new('two', self, 'O')]
    puts "#{players[0].name} is facing off #{players[1].name}. Let the game begin!"
  end

  def board_full?
    vacant_positions = (1..9).select do |position|
      board[position].nil?
    end
    vacant_positions.empty?
  end

  def player_has_won?
    winning_line('X') || winning_line('O')
  end

  def winning_line(marker)
    WINNING_COMBINATIONS.each do |combination|
      markers_in_line = combination.select { |position| board[position] == marker }
      return true if markers_in_line.length == 3
    end
    false
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
