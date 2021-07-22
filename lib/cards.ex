defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @typedoc """
  A card
  """
  @type card :: %{rank: String.t(), suit: String.t()}

  @typedoc """
  A deck of cards
  Note that the original diagram states that create_deck will "Create an array of playing cards"
  Using an array wouldn't make sense to me. For now, I'm using a list instead.
  (I assume that Stephen will do the same, but we'll see.)
  """
  @type deck :: list(card)

  @typedoc """
  A hand of cards
  """
  @type hand :: list(card)

  @doc """
  I'll pass in ranks and suits
  by default, the ranks will be A 2 3 4 5 6 7 8 9 10 J Q K
  the default suits will be H S C D
  """
  @spec create_deck(list(String.t()), list(String.t())) :: deck
  def create_deck(
        ranks \\ ["ace", "deuce", "trey", "sailboat", "five", "six", "seven", "snowman", "nine", "ten", "jack", "queen", "king"],
        suits \\ ["hearts", "spades", "clubs", "diamonds"]
      ) do
        Enum.flat_map(suits, fn suit -> Enum.map(ranks, fn rank -> %{rank: rank, suit: suit} end) end)
  end

  def shuffle() do
  end

  def deal() do
  end

  def contains? do
  end

  def save do
  end

  def load do
  end
end
