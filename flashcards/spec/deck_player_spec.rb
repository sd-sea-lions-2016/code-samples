require_relative 'spec_helper'

describe DeckPlayer do
  let(:card_a) { Flashcard.new(prompt: "What is it?", answer: "Something") }
  let(:card_b) { Flashcard.new(prompt: "Why?", answer: "Because") }
  let(:cards) { [card_a, card_b] }
  let(:deck) { Deck.new(cards: cards) }
  let(:deck_player) { DeckPlayer.new(deck: deck) }

  describe "attributes" do
    it "has a deck" do
      expect(deck_player.deck).to be deck
    end

    it "has a score" do
      expect(deck_player.score).to eq 0
    end
  end

  describe "increasing the score" do
    it "can increase its score" do
      expect{deck_player.add_point}.to change{deck_player.score}.by(1)
      deck_player.add_point
    end
  end

  describe "play" do
    it "plays each card in its deck" do
      allow(CardPlayer).to receive(:play)

      deck_player.deck.each do |card|
        expect(CardPlayer).to receive(:play).with(card)
      end

      deck_player.play
    end

    it "adds points for every correct guess" do
      allow(CardPlayer).to receive(:play) { true }

      expect{deck_player.play}.to change{deck_player.score}.by(deck_player.deck.card_count)
    end

    it "tells the view to display the final score" do
      allow(CardPlayer).to receive(:play)
      allow(DeckPlayerView).to receive(:render_outcome)

      expect(DeckPlayerView).to receive(:render_outcome).with(deck_player)

      deck_player.play
    end
  end
end
