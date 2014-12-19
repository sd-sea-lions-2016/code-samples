require_relative 'spec_helper.rb'

describe FlashcardParser do
  describe ".parse" do
    it "returns a collection of flashcards" do
      stub_read_flashcard_data

      FlashcardParser.parse("filename").each do |card|
        expect(card).to be_an_instance_of Flashcard
      end
    end

    it "passes the approriate data calling for new flashcards" do
      stub_read_flashcard_data

      expect(Flashcard).to receive(:new).with({prompt: "first prompt", answer: "first answer"})
      expect(Flashcard).to receive(:new).with({prompt: "second prompt", answer: "second answer"})

      FlashcardParser.parse("filename")
    end
  end
end
