require_relative 'human'
require_relative 'computer'
require_relative 'display'

class Game
  include Display

  def start
    system('clear')
    puts display_game_messages(:greet)
    print display_game_messages(:game_option)
    game_mode = get_game_mode

    if game_mode == '1'
      code_breaker
    elsif game_mode == '2'
      code_maker
    elsif game_mode == 'q'
      conclusion
      return nil
    end

    if play_again?
      start
    end
    conclusion
  end

  def get_game_mode
    game_mode = gets.chomp
    return game_mode if game_mode == '1' || game_mode == '2' || game_mode == 'q'
    print display_warnings(:game_mode_error)
    get_game_mode
  end

  def code_breaker
    human = Human.new
    human.start_breaking
  end

  def code_maker
    computer = Computer.new
    computer.start_breaking
  end

  def play_again?
    puts ''
    print display_game_messages(:play_again)
    answer = gets.chomp
    if answer == 'Y' || answer == 'y'
      return true
    else
      return false
    end
  end

  def conclusion
    puts display_game_messages(:endgame)
  end
end
