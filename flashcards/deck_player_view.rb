module DeckPlayerView
  def self.render_outcome(deck_player)
    puts "You correctly answered #{deck_player.score} of #{deck_player.deck.card_count} cards."
  end
end
