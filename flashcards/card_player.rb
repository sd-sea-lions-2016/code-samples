class CardPlayer
  def self.play(card)
    CardView.render_prompt(card)
    CardView.render_outcome(guess_outcome = (card.correct?(CardView.get_guess)))

    return guess_outcome
  end
end
