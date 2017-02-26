class Secret
  attr_reader :secret
  
  def initialize
    create_secret
  end

  private

  def create_secret
    @secret = []

    4.times do
      @secret << rand(1..6)
    end
  end

end