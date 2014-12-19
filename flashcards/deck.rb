class Deck
  attr_reader :cards

  def initialize(args)
    @cards = args[:cards]
  end

  def each
    cards.each do |card|
      yield(card)
    end
  end

  def card_count
    cards.count
  end
end
