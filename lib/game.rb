# frozen_string_literal: true

# Manages current board and player interactions
class Game
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

    @current_player_idx = 0
    @players = [HumanPlayer.new('one', self, 'X'), HumanPlayer.new('two', self, 'O')]

    puts "\n#{players[0].name} is facing off #{players[1].name}. Let the game begin!"
    puts "#{current_player} goes first.\n"
    print_board
  end

  attr_reader :board, :players
  attr_accessor :current_player_idx

  def current_player
    players[current_player_idx]
  end

  def other_player
    players[other_player_idx]
  end

  def play
    while !board_full? && !player_has_won?
      place_current_player_marker
      switch_players
      print_board
    end
    if board_full?
      puts "\nIt's a tie! Game over."
    elsif player_has_won?
      puts "\n#{other_player} has won! Game over."
    end
  end

  def place_current_player_marker
    position = select_player_move
    board[position] = current_player.marker
  end

  def select_player_move
    puts "\n#{current_player}, place your move! Pick a number between 1 and 9"
    print '=> '
    position = gets.chomp.to_i
    until position.between?(1, 9) && vacant_positions.include?(position)
      puts 'Invalid choice. Please choose another number'
      print '=> '
      position = gets.chomp.to_i
    end

    puts "\n#{current_player} placed their move!"

    position
  end

  def other_player_idx
    1 - current_player_idx
  end

  def switch_players
    self.current_player_idx = other_player_idx
  end

  def vacant_positions
    (1..9).select { |position| board[position].nil? }
  end

  def board_full?
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
      board[position] || position.to_s
    end

    row_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    format_row = lambda do |row|
      row.map(&get_position_label).join(column_separator)
    end

    puts row_positions.map(&format_row).join("\n#{row_separator}\n")
  end
end
