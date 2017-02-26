require_relative "board"
require_relative "secret"

class Game
  def initialize(guesser = :human)
    @guesser = guesser
    (@guesser == :human) ? @secret = Secret.new::secret : define_secret
    @board = Board.new
    @guesses = 0
    @current_guess = []
    @current_result = []
    @result_set = []
    play
  end

  def define_secret
    puts "choose your secret"
    loop do
      secret = gets.chomp.split("")
      secret.map! { |e| e.to_i }
      if valid_guess?(secret)
        @secret = secret
        break
      end
      puts "Not a valid guess. Try again (1234)"
    end
  end

  def play
    until game_over?
      @guesser == :human ? guess : random_guess
      check(@current_guess)
      @result_set << [ @current_guess.join(' '), @current_result.sort.join(' ')]
      @board.update_and_show_board(@result_set)
      #@board.update_and_show_board(@result_set, @secret.join(' '))
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

  def random_guess
    puts "Make your guess. You have #{12 - @guesses} remaining..."

    @current_guess = []

    4.times do
      @current_guess << rand(1..6)
    end

    @guesses += 1
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

puts "Would you like to (g)uess or (c)reate the secret?"
role = gets.chomp
if role == "g"
  Game.new(:human)
else 
  Game.new(:bot)
end
