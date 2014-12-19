class Flashcard
  attr_reader :prompt, :answer

  def initialize(args)
    @prompt = args[:prompt]
    @answer = args[:answer]
  end

  def correct?(guess)
    guess == self.answer
  end
end
