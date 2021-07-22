defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "can create deck with one card" do
    assert Cards.create_deck(["one"], ["only"]) == [%{rank: "one", suit: "only"}]
  end

end
