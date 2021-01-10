require_relative 'colors'

module Display
  def code_colors(num)
    {
      1 => '  1  '.bg_blue,
      2 => '  2  '.bg_red,
      3 => '  3  '.bg_green,
      4 => '  4  '.bg_brown,
      5 => '  5  '.bg_magenta,
      6 => '  6  '.bg_cyan
    }[num]
  end

  def key_pegs(peg)
    {
      exact: "\u26AB".red,
      number_only: "\u26AB".gray
    }[peg]
  end

  def display_player_prompt(turn = nil)
    puts "Turn #{turn}" unless turn.nil?
    puts "Type your guess (only 4 numbers, 1-6 each):"
  end

  def display_show_input_error(option)
    if option == :size
      puts "The guess must be 4 numbers long."
      display_player_prompt
    elsif option == :range
      puts "Each number must be between 1-6."
      display_player_prompt
    end
  end

  def display_show_hints(exact, number_only)
    print '  (Hints: '
    exact.times { print key_pegs(:exact) }
    number_only.times { print key_pegs(:number_only) }
    print ')'
    puts ''
    puts ''
  end

  def display_show_code(code)
    code.each { |num| print code_colors(num) }
  end

  def display_human_win
    puts "Well done! you broke the code!"
  end
  
  def display_computer_win
    puts "Not today! The computer wins!"
  end
end

