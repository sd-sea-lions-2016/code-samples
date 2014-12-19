require_relative 'spec_helper'

describe Deck do
  let(:card_a) { Flashcard.new(prompt: "Am I here?", answer: "No.") }
  let(:card_b) { Flashcard.new(prompt: "Who am I?", answer: "You.") }
  let(:deck) { Deck.new(cards: [card_a, card_b]) }

  describe "attributes" do
    it "has cards" do
      expect(deck.cards).to match_array [card_a, card_b]
    end
  end

  it "can iterate over its cards" do
    expect(deck).to receive(:each).and_yield(card_a).and_yield(card_b)

    deck.each { |arg| }
  end

  it "knows how many cards it has" do
    expect(deck.card_count).to eq 2
  end
end
