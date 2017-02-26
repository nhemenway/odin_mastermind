class Board
  def initialize
    @board = []
    make_board
  end

  def make_board
    12.times do
      @board << ['o o o o','']
    end

  end

  def update_and_show_board(results, secret = '? ? ? ?')
    update_board(results)
    show_board(@board, secret)
  end

  def update_board(results)
    results.length.times do
      @board.pop
    end
    
    results.reverse_each do |result|
      @board << result
    end
  end

  def show_board(board, secret)
    separator = '  |  '
    puts "       " + secret
    board.each_with_index do |turn, i|
      i = (12 - i)
      i < 10 ? i = "0" + i.to_s : i = i.to_s 
      puts i + separator + turn[0].to_s + separator + turn[1].to_s
    end
  end

end


#        ? ? ? ?
# 12  |  o o o o  |  + + - -
# 11  |  1 4 5 7  |  + - -