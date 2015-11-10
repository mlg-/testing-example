require_relative 'deck'

class Hand
  def initialize(cards = [])
    @cards = cards
  end

  def calculate_hand()
    score = 0
    @cards.each do |card|
      score += card_value(card)
    end
    if score < 12 && @cards.any?{|card| card[0] == 'A'}
      score += 10
    end
    score
  end

  def card_value(card)
    rank = card[0...-1]
    if ['J', 'Q', 'K'].include?(rank)
      10
    elsif rank == 'A'
      1
    else
      rank.to_i
    end
  end
end

deck = Deck.new
cards = deck.deal(2)
hand = Hand.new(cards)
hand.calculate_hand
