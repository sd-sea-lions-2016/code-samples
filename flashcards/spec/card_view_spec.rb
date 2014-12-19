require_relative 'spec_helper'

describe CardView do
  let(:card) { double("flashcard", prompt: "You like to test, right?") }

  before(:each) do
    allow(STDOUT).to receive(:puts)
    allow(STDIN).to receive(:gets) { "Yes, I do.\n" }
  end

  describe ".render_prompt" do
    it "displays card prompts" do
      expect(STDOUT).to receive(:puts).with("You like to test, right?")
      CardView.render_prompt(card)
    end
  end

  describe ".get_guess" do
    it "prompts the user for a guess" do
      expect(STDOUT).to receive(:puts).with("Enter your guess.")
      CardView.get_guess
    end

    it "returns the users input" do
      expect(CardView.get_guess).to eq "Yes, I do."
    end
  end

  describe ".render_outcome" do
    context "guess correct" do
      it "alerts the user that the guess was correct" do
        expect(STDOUT).to receive(:puts).with("Correct!")
        CardView.render_outcome(true)
      end
    end

    context "guess incorrect" do
      it "alerts the user that the guess was incorrect" do
        expect(STDOUT).to receive(:puts).with("Wrong!")
        CardView.render_outcome(false)
      end
    end
  end
end
