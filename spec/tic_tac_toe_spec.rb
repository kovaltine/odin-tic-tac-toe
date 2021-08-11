# frozen_string_literal: true

require '../lib/tic_tac_toe'

# make sure players win when they should
describe 'check for horizontal wins' do
  context 'check for a top row win' do
    let(:winner_game) { Game.new(board: ['X', 'X', 'X', nil, nil, nil, nil, nil, nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end

  context 'check for a middle row win' do
    let(:winner_game) { Game.new(board: ['O', 'O', nil, 'X', 'X', 'X', nil, nil, nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end

  context 'check for a bottom row win' do
    let(:winner_game) { Game.new(board: ['O', 'O', nil, nil, nil, nil, 'X', 'X', 'X']) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end
end

describe 'check for vertical wins' do
  context 'checks for left column win' do
    let(:winner_game) { Game.new(board: ['X', nil, nil, 'X', nil, nil, 'X', nil, nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end

  context 'checks for center column win' do
    let(:winner_game) { Game.new(board: [nil, 'X', nil, nil, 'X', nil, nil, 'X', nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end

  context 'checks for right column win' do
    let(:winner_game) { Game.new(board: [nil, nil, 'X', nil, 'X', nil, 'X', nil, nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end
end

describe 'check for diagonal wins' do
  context 'checks for left diagonal win' do
    let(:winner_game) { Game.new(board: ['X', nil, nil, nil, 'X', nil, nil, nil, 'X']) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end

  context 'checks for right diagonal win' do
    let(:winner_game) { Game.new(board: [nil, nil, 'X', nil, 'X', nil, 'X', nil, nil]) }
    it 'will return true' do
      expect(winner_game.check_winner?).to eq(true)
    end
  end
end

describe 'check for the absence of wins' do
  context 'there are no wins on the board' do
    let(:no_win) { Game.new(board: ['X', 'O', 'X', 'O', 'X', 'O', 'O', nil, nil]) }
    it 'will return false' do
      expect(no_win.check_winner?).to eq(false)
    end
  end
end

# check crucial functions to make sure it works properly

describe 'check draw' do
  context 'checks for the presence of a draw' do
    let(:draw_game) { Game.new(board: %w[X O X X X O O X O]) }
    it 'will return true' do
      expect(draw_game.check_draw?).to eq(true)
    end
  end

  context 'checks for the absence of a draw' do
    let(:draw_game) { Game.new(board: ['X', 'O', 'X', 'O', 'X', 'O', 'O', nil, nil]) }
    it 'will return false' do
      expect(draw_game.check_draw?).to eq(false)
    end
  end
end

describe 'valid input' do
  context 'make sure the user enters a valid input' do
    let(:valid_input) { Game.new(board: ['X', 'O', 'X', 'O', 'X', 'O', 'O', nil, nil]) }
    it 'will return false' do
      expect(valid_input.valid_input?(9)).to eq(false)
    end
    it 'will return true' do
      expect(valid_input.valid_input?(8)).to eq(true)
    end
    it 'if the spot is taken will return false' do
      expect(valid_input.valid_input?(2)).to eq(false)
    end
  end
end

describe 'end game' do
  context 'end the game if there is a winner or a draw' do
    let(:end_game) { Game.new(board: ['X', nil, nil, nil, 'X', nil, nil, nil, 'X']) }
    it 'winning configuration will return true' do
      expect(end_game.end_game?).to eq(true)
    end
  end
  context 'draw configuration will return true' do
    let(:end_game) { Game.new(board: %w[X O X X X O O X O]) }
    it 'will return false' do
      expect(end_game.end_game?).to eq(true)
    end
  end
end
