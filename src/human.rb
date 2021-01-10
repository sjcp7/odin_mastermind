require_relative 'display'
require_relative 'game_logic'
require 'pry'

class Human
  include Display
  include GameLogic
  def initialize
    @computer_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def start_breaking
    play_turns
    conclusion
  end

  private

  def play_turns
    turn = 1
    while turn <= 12 do
      @guess = get_player_guess(turn)
      display_show_code(@guess)
      turn_result
      break if code_broken?(@guess, @computer_code)
      turn += 1
    end
  end

  def get_player_guess(turn)
    print display_turn_messages(:guess_prompt, turn)
    guess = gets.chomp.split('').map(&:to_i)
    return guess if guess.size == 4 && guess.all? { |num| num.between?(1, 6) }
    puts display_warnings(:guess_error)
    get_player_guess(turn)
  end

  def turn_result
    compare(@guess, @computer_code)
    display_show_hints(@exact_matches, @right_numbers)
  end

  def conclusion
    if code_broken?(@guess, @computer_code)
      puts display_game_messages(:human_breaker_won)
    else
      puts display_game_messages(:computer_maker_won)
      puts display_game_messages(:code)
      display_show_code(@computer_code)
    end
  end
end
