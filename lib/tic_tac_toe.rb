# frozen_string_literal: true

require 'colorize'

# to start a game, create a new Game object
class Game
  attr_accessor :board

  WINS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # <-- Horizontal wins
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # <-- Vertical wins
    [0, 4, 8], [2, 4, 6] # <-- Diagonal wins
  ].freeze

  def initialize(board: Array.new(9) { |i| i }, win: false, draw: false)
    @board = board
    @player = 'X'.colorize(:light_blue)
    @win = win
    @draw = draw
  end

  # private

  # def create_board
  #   Array.new(9) { |i| i }
  # end

  # display the board
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'.colorize(:yellow)
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'.colorize(:yellow)
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end

  # toggle X's and O's between players
  def player
    @player = if @player == 'X'.colorize(:light_blue)
                'O'.colorize(:red)
              else
                'X'.colorize(:light_blue)
              end
  end

  # if the board matches any item from the WINS array, then declare the winner
  def check_winner?
    return true if WINS.any? { |line| line.all? { |square| @board[square] == @player } }

    false
  end

  # if there are no free squares declare a draw
  def check_draw?
    return true if @board.all? { |square| square.is_a? String }

    false
  end

  # keep taking player moves until there's a win or a draw
  def play_round
    display_board
    until end_game?
      player_move
      break if end_game?

      display_board
      player
    end

    display_end
  end

  def end_game?
    @win = check_winner?
    @draw = check_draw?
    return true if @win == true
    return true if @draw == true

    false
  end

  def display_end
    puts "\nGood Game!\n".colorize(:yellow)
    puts "The winner is #{@player}" if @win
    puts "It's a draw!" if @draw
  end

  # take player input and change the board
  def player_move
    puts "\n#{@player} : pick your square"
    # to_i will convert any string to 0
    position = gets.to_i
    if valid_input?(position)
      @board[position] = @player
    else
      player_move
    end
  end

  def valid_input?(input)
    return false unless input.between?(0, 8)
    return false if @board[input].is_a? String

    true
  end
end

def play_game
  Game.new.play_round while play_again?
  puts 'okay see you later!'
end

def play_again?
  puts "Would you like to play tic tac toe? type 'y' to start"
  new_game = gets.chomp.downcase
  return true if new_game == 'y'

  false
end

play_game
