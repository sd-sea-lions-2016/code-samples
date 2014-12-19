require_relative 'spec_helper'

describe CardPlayer do
  let(:flashcard) { double("flashcard", :prompt => "Best cohort ever?", :answer => "Otters 2013", :correct? => true) }

  describe "playing a card" do

    before(:each) do
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets) { "Otters 2013\n" }
    end

    it "passes the card to have the prompt displayed" do
      expect(CardView).to receive(:render_prompt).with(flashcard)
      CardPlayer.play(flashcard)
    end

    it "tells the view to get the users response" do
      allow(CardView).to receive(:render_prompt)

      expect(CardView).to receive(:get_guess)
      CardPlayer.play(flashcard)
    end

    it "checks with the card to see if the user's guess was correct" do
      expect(flashcard).to receive(:correct?)
      CardPlayer.play(flashcard)
    end

    it "tells the view to give the user feedback on the guess" do
      expect(CardView).to receive(:render_outcome)
      CardPlayer.play(flashcard)
    end

    it "returns true if the user guesses correctly" do
      expect(CardPlayer.play flashcard).to be true
    end

    it "returns flase if the use guesses incorrectly" do
      allow(flashcard).to receive(:correct?) { false }
      expect(CardPlayer.play flashcard).to be false
    end
  end
end
