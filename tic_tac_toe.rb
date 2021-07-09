# frozen_string_literal: true

# to start a game, create a new Game object
class Game
  # this constant shows winning combinations
  WINS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # <-- Horizontal wins
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # <-- Vertical wins
    [0, 4, 8], [2, 4, 6] # <-- Diagonal wins
  ].freeze

  def initialize
    @board = Array.new(9) { |i| i }
    display_board
    @player = 'X'
    @win = false
    @draw = false
    play_game
  end

  private

  # display the board
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    check_winner?
    check_draw?
  end

  # toggle X's and O's between players
  def player
    @player = if @player == 'X'
                'O'
              else
                'X'
              end
  end

  # if the board matches any item from the WINS array, then declare the winner
  def check_winner?
    return unless WINS.any? { |line| line.all? { |square| @board[square] == @player } }

    puts "The winner is #{@player}"
    @win = true
  end
end

# if there are no free squares declare a draw
def check_draw?
  return unless @board.all? { |square| square.is_a? String }

  puts "It's a draw!"
  @draw = true
end

# keep taking player moves until there's a win or a draw
def play_game
  player_move while @win == false && @draw == false
  puts 'Good Game!'
end

  # methods that need user input are public
  public

# take player input and change the board
def player_move
  puts "What square would #{@player} like?"
  position = gets.to_i
  return puts 'invalid move' unless position.between?(0, 8)
  # if that square is already taken, player will have to try again
  return puts 'invalid move' if @board[position].is_a? String

  @board[position] = @player
  display_board
  player
end

# start the game
def start_game
  puts "Would you like to start a game? type 'y' to start"
  new_game = gets.chomp.downcase
  if new_game == 'y'
    puts 'Starting game'
    game = Game.new
  else
    puts 'okay see you later!'
  end
end

start_game
