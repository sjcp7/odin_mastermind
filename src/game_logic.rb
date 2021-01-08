module GameLogic
  def compare(guess, code)
    exact_matches_hash = {}
    @exact_matches = get_exact_matches(guess, code, exact_matches_hash)
    @right_numbers = get_right_numbers(guess, code, exact_matches_hash)
  end

  def get_exact_matches(guess, code, matches_hash)
    matches = 0
    code.each_with_index do |num, pos|
      next unless num == guess[pos]
      matches += 1
      matches_hash[pos] = '*'
    end
    matches
  end

  def get_right_numbers(guess, code, exact_matches_hash)
    matches = 0
    code.each_with_index do |num, pos|
      next unless exact_matches_hash[pos] != '*' && guess.include?(num)
      matches += 1
    end
    matches
  end

  def code_broken?(guess, code)
    guess == code
  end

end
