require_relative 'spec_helper'

describe Flashcard do
  let(:flashcard) { Flashcard.new(prompt: "Is this for real?", answer: "Yep.") }

  describe "attributes" do
    it "has a prompt" do
      expect(flashcard.prompt).to eq "Is this for real?"
    end

    it "has an answer" do
      expect(flashcard.answer).to eq "Yep."
    end
  end

  describe "#correct?" do
    it "returns true if a guess is correct" do
      expect(flashcard.correct? "Yep.").to be true
    end

    it "returns false if a guess is incorrect" do
      expect(flashcard.correct? "Incorrect guess").to be false
    end
  end
end
