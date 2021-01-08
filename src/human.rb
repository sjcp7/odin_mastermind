require_relative 'display'
require_relative 'game_logic'
require 'pry'

class Human
  include Display
  include GameLogic
  def initialize
    random_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @computer_code = random_numbers.map(&:to_s)
  end

  def start_breaking
    play_turns
    conclusion
  end

  private

  def play_turns
    turn = 1
    while turn <= 12 do
      display_player_prompt(turn)
      @guess = get_player_guess
      display_show_code(@guess)
      turn_result
      break if code_broken?(@guess, @computer_code)
      turn += 1
    end
  end

  def get_player_guess
    guess = gets.chomp.split('')

    unless guess.size == 4
      display_show_input_error(:size)
      get_player_guess
    end

    unless guess.all? { |char| char.to_i.between?(1, 6)}
      display_show_input_error(:range)
      get_player_guess
    end
    guess
  end

  def turn_result
    compare(@guess, @computer_code)
    display_show_hints(@exact_matches, @right_numbers)
  end

  def conclusion
    if code_broken?(@guess, @computer_code)
      display_human_win
    else
      display_computer_win
    end
  end
end
