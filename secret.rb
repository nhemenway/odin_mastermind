class Secret
  attr_reader :secret
  
  def initialize
    generate_secret
  end

  private

  def generate_secret
    @secret = []

    4.times do
      @secret << rand(1..6)
    end
  end

  def set_secret

  end

end