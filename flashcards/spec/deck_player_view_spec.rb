require_relative 'spec_helper'

describe DeckPlayerView do
  let(:deck) { double("deck", card_count: 10) }
  let(:deck_player) { double("deck player", deck: deck, score: 6) }

  describe ".render_outcome" do
    it "displays the final score to the user" do
      expect(STDOUT).to receive(:puts).with("You correctly answered 6 of 10 cards.")
      DeckPlayerView.render_outcome(deck_player)
    end
  end
end
