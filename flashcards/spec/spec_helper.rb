require_relative '../flashcard_parser'
require_relative '../flashcard'
require_relative '../deck'
require_relative '../card_player'
require_relative '../card_view'
require_relative '../deck_player'
require_relative '../deck_player_view'

require_relative './support/flashcard_data_macros'

RSpec.configure do |config|
  config.order = :random

  config.include FlashcardDataMacros
end
