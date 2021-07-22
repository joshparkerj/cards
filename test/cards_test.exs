defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "can create deck with one card" do
    assert Cards.create_deck(["one"], ["only"]) == [%{rank: "one", suit: "only"}]
  end

  test "can deal one card from deck with one card" do
    assert Cards.deal([%{rank: "one", suit: "only"}],[],1) == {[], [%{rank: "one", suit: "only"}]}
  end

  test "can deal one card from deck with two cards" do
    assert Cards.deal(Cards.create_deck(["one", "two"],["only"]), [], 1) == {[%{rank: "two", suit: "only"}],[%{rank: "one", suit: "only"}]}
  end

  test "can deal one card into hand with one card" do
    deck = Cards.create_deck(["one"], ["only"])
    hand = Cards.create_deck(["two"], ["only"])
    assert Cards.deal(deck, hand, 1) == {[], [%{rank: "two", suit: "only"},%{rank: "one", suit: "only"}]}
  end

end
