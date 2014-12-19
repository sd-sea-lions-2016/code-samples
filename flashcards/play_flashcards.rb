if ARGV.any?
  require_relative 'flashcard_parser'
  require_relative 'flashcard'
  require_relative 'deck'
  require_relative 'card_player'
  require_relative 'card_view'
  require_relative 'deck_player'
  require_relative 'deck_player_view'

  FILENAME = ARGV[0]

  flashcards = FlashcardParser.parse(FILENAME)
  deck = Deck.new(cards: flashcards)

  DeckPlayer.new(deck: deck).play
end
