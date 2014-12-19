module CardView
  def self.render_prompt(card)
    puts card.prompt
  end

  def self.get_guess
    puts "Enter your guess."
    guess = $stdin.gets.chomp
  end

  def self.render_outcome(guess_correctness)
    puts guess_correctness ? "Correct!" : "Wrong!"
  end
end
