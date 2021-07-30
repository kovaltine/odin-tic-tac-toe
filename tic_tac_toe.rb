# frozen_string_literal: true

require 'colorize'

# to start a game, create a new Game object
class Game
  WINS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # <-- Horizontal wins
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # <-- Vertical wins
    [0, 4, 8], [2, 4, 6] # <-- Diagonal wins
  ].freeze

  def initialize
    @board = Array.new(9) { |i| i }
    display_board
    @player = 'X'.colorize(:light_blue)
    @win = false
    @draw = false
    play_game
  end

  private

  # display the board
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'.colorize(:yellow)
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'.colorize(:yellow)
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    check_winner?
    check_draw?
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
    return unless WINS.any? { |line| line.all? { |square| @board[square] == @player } }

    puts "The winner is #{@player}"
    @win = true
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
    puts "\nGood Game!\n".colorize(:yellow)
    puts "Would you like to play again? type 'y' to start"
    new_game = gets.chomp.downcase
    if new_game == 'y'
      Game.new
    else
      puts 'okay see you later!'
    end
  end

  # take player input and change the board
  def player_move
    puts "\n#{@player} : pick your square"
    position = gets.to_i
    return puts 'invalid move' unless position.between?(0, 8)
    return puts 'invalid move' if @board[position].is_a? String

    @board[position] = @player
    display_board
    player
  end
end

Game.new
