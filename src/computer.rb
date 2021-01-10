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
    code = gets.chomp.split('').map(&:to_i)
    unless code.size == 4
      display_show_input_error(:size)
      get_human_code
    end

    unless code.all? { |num| num.between?(1, 6) }
      display_show_input_error(:range)
      get_human_code
    end
    code
  end

  def play_turns
    turn = 1
    code_set = initialize_code_set
    @guess = [1, 1, 2, 2]
    turn_result
    return nil if code_broken?(@guess, @human_code)
    remove_unmatching_codes(@guess, code_set)
    while turn <= 12 do
      @guess = code_set.first
      turn_result
      sleep(1)
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

  def turn_result
    compare(@guess, @human_code)
    display_show_code(@guess)
    display_show_hints(@exact_matches, @right_numbers)
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
    if code_broken?(@guess, @computer_code)
      display_computer_win
    else
      display_human_win
    end
  end
end
