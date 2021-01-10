require_relative 'display'
require_relative 'game_logic'
require 'pry'

class Computer
  include Display
  include GameLogic
  
  def start_breaking
    @human_code = get_human_code
    play_turns
    conclusion
  end

  private

  def get_human_code
    print display_turn_messages(:human_code_prompt)
    code = gets.chomp.split('').map(&:to_i)
    return code if code.size == 4 && code.all? { |num| num.between?(1, 6) }
    puts display_warnings(:human_code_error)
    get_human_code
  end

  def play_turns
    system('clear')
    turn = 1
    code_set = initialize_code_set
    @guess = [1, 1, 2, 2]
    turn_result(turn)
    return nil if code_broken?(@guess, @human_code)
    remove_unmatching_codes(@guess, code_set)
    turn += 1

    while turn <= 12 do
      @guess = code_set.first
      turn_result(turn)
      break if code_broken?(@guess, @human_code)
      remove_unmatching_codes(@guess, code_set)
      turn += 1
    end
  end

  def initialize_code_set
    set = []
    6.times do |i|
      6.times do |j|
        6.times do |k|
          6.times do |l|
            set.push([i + 1, j + 1, k + 1, l + 1])
          end
        end
      end
    end
    set
  end

  def turn_result(turn)
    puts display_turn_messages(:computer_turn, turn)
    compare(@guess, @human_code)
    display_show_code(@guess)
    display_show_hints(@exact_matches, @right_numbers)
    sleep(1)
  end

  def remove_unmatching_codes(guess, code_set)
    code_set.filter! do |code|
      exact_matches_hash = {}
      exact_matches = get_exact_matches(guess, code, exact_matches_hash)
      right_numbers = get_right_numbers(guess, code, exact_matches_hash)
      key_pegs_match?(exact_matches, right_numbers)
    end
  end

  def key_pegs_match?(exact_matches, right_numbers)
    @exact_matches == exact_matches && right_numbers == @right_numbers
  end

  def conclusion
    if code_broken?(@guess, @human_code)
      puts display_game_messages(:computer_breaker_won)
    else
      puts display_game_messages(:human_maker_won)
    end
  end
end
