require_relative '../lib/blackjack'

describe Deck do
  let(:deck) { Deck.new } # creates a variable that can be used for tests

  describe "#build_deck" do
    it "builds a deck of 52 cards" do
      expect(deck.cards.size).to eq 52
    end

    it "creates unique cards" do
      expect(deck.cards.uniq.size).to eq 52
    end

    it "shuffles the deck after it is built" do
      expect(deck.cards.sort).to_not eq deck.cards
      expect(deck.cards.sort[0..1]).to eq ['10♠', '10♣']
    end
  end

  describe "#deal" do
    it "removes correct number of cards" do
      full_deck = deck.cards.size

      deck.deal(2)

      expect(deck.cards.size).to eq(full_deck - 2)
    end

    it "deals the top card in the deck" do
      correct_card = deck.cards[-1]
      expect(deck.deal(1)).to eq [correct_card]
    end
  end
end

describe Hand do
  let(:typical_hand) { Hand.new(["10♦", "J♥"]) }
  let(:one_ace_hand) { Hand.new(["A♠", "5♥"])}
  let(:one_ace_one_face) { Hand.new(["K♠", "Q♦", "A♦"])}
  let(:another_one_ace) { Hand.new(["9♦", "7♥", "A♣"])}
  let(:last_one_ace) { Hand.new(["5♦", "A♠"])}
  let(:two_aces) { Hand.new(["5♦", "A♠", "A♣" ])}
  let(:three_aces) { Hand.new(["2♠", "A♠", "A♣", "A♦"]) }

  describe "#calculate_hand" do
    it "calculates the hand correctly in many cases" do
      expect(typical_hand.calculate_hand).to eq(20)
      expect(one_ace_hand.calculate_hand).to eq(16)
      expect(one_ace_one_face.calculate_hand).to eq(21)
      expect(another_one_ace.calculate_hand).to eq(17)
      expect(last_one_ace.calculate_hand).to eq(16)
      expect(two_aces.calculate_hand).to eq(17)
      expect(three_aces.calculate_hand).to eq(15)
    end

    it "does not make any common logical errors when calculating the score" do
      expect(typical_hand.calculate_hand).to_not eq(19)
      expect(one_ace_hand.calculate_hand).to_not eq(6)
      expect(one_ace_one_face.calculate_hand).to_not eq(31)
      expect(last_one_ace.calculate_hand).to_not eq(6)
      expect(another_one_ace.calculate_hand).to_not eq(27)
      expect(two_aces.calculate_hand).to_not eq(27)
      expect(three_aces.calculate_hand).to_not eq(5)
    end
  end


  let(:hand) { Hand.new }

  describe "#card_value" do
    it "accurately returns the card's value" do
      expect(hand.card_value("10♦")).to eq(10)
      expect(hand.card_value("2♦")).to eq(2)
      expect(hand.card_value("J♠")).to eq(10)
      expect(hand.card_value("A♥")).to eq(1)
    end

    it "doesn't understand the card's value" do
      expect(hand.card_value("A♥")).to_not eq(11)
    end
  end
end
