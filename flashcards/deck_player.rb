class DeckPlayer
  attr_reader :deck
  attr_accessor :score

  def initialize(args)
    @deck = args[:deck]
    @score = 0
  end

  def add_point
    self.score = score + 1
  end

  def play
    deck.each do |card|
      add_point if CardPlayer.play(card)
    end

    DeckPlayerView.render_outcome(self)
  end
end
