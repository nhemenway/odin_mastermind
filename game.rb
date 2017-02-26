require_relative "board"
require_relative "secret"

class Game
  def initialize
    @secret = Secret.new::secret
    @board = Board.new
    @guesses = 0
    @current_guess = []
    @current_result = []
    @result_set = []
    play
  end

  def play
    #puts "the secret is " + @secret::secret.to_s
    until game_over?
      guess
      check(@current_guess)
      @result_set << [ @current_guess.join(' '), @current_result.sort.join(' ')]
      @board.update_and_show_board(@result_set, @secret.join(' '))
    end

    end_game
  end

  def guess
    puts "Make your guess. You have #{12 - @guesses} remaining..."
    loop do
      guess = gets.chomp.split("")
      guess.map! { |e| e.to_i }
      if valid_guess?(guess)
        @current_guess = guess
        @guesses += 1
        break
      end
      puts "Not a valid guess. Try again (1234)"
    end
    
  end

  def valid_guess?(guess)
    guess.length == 4 && guess.all? { |g| g.between?(1, 6) } ? true : false
  end

  def check(guess)
    @current_result = []
    guess.each_with_index do |g, i|
      if g == @secret[i]
        @current_result << "+"
      elsif @secret.include? g
        @current_result << "-"
      end
    end
  end

  def game_over?
    @current_guess == @secret || @guesses == 12 ? true : false
  end

  def end_game
    if @current_guess == @secret 
      puts "Well done, you won!"
    else
      puts "Looks like you're the loser!"
    end
    @board.update_and_show_board(@result_set, @secret.join(' '))
  end
end

Game.new
