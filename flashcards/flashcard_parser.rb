class FlashcardParser
  def self.parse(filename)
    File.readlines(filename).map(&:strip).each_slice(3).map do |card_data|
      Flashcard.new(prompt: card_data[0], answer: card_data[1])
    end
  end
end
