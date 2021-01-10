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

  def display_game_messages(message)
    {
      greet: "Hi, welcome to Mastermind!",
      game_option: "Type '1' to be the Code Breaker, '2' to be the Code Maker or 'q' to quit: ",
      endgame: "Thank you for playing! See ya!",
      human_breaker_won: "Congratulations! You broke the code!",
      human_maker_won: "Impressive! You tricked the computer!",
      computer_breaker_won: "Too bad! The computer broke your code.",
      computer_maker_won: "Good effort, but you couldn't decipher the code.",
      code: "Here's the code you were trying to break: ",
      play_again: "Do you want to play again? [y/n]: "
    }[message]
  end
  
  def display_turn_messages(message, turn = nil)
    {
      guess_prompt: "Turn #{turn} - Type your guess or 'q' to quit (4 numbers, 1-6 each): ",
      computer_turn: "Computer Turn #{turn}",
      human_code_prompt: "Type a secret code for the computer to decipher (4 numbers, 1-6 each): "
    }[message]
  end

  def display_warnings(warning) 
    {
      game_mode_error: "Please, type '1' to be the Code Breaker or '2' to be the Code Maker: ".red,
      guess_error: "Your guess must be 4 numbers, 1-6 each.".red,
      human_code_error: "The secret code must be 4 numbers, 1-6 each.".red
    }[warning]
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
end
