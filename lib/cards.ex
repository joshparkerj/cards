defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  def hello do
    "hi there!"
  end

  @typedoc """
  A card
  """
  @type card :: %{rank: String.t(), suit: String.t()}

  @typedoc """
  A deck of cards
  Note that the original diagram states that create_deck will "Create an array of playing cards"
  Using an array wouldn't make sense to me. For now, I'm using a list instead.
  (I assume that Stephen will do the same, but we'll see.)
  Note that a hand is effectively just a deck.
  """
  @type deck :: list(card)

  @doc """
  I'll pass in ranks and suits
  by default, the ranks will be A 2 3 4 5 6 7 8 9 10 J Q K
  the default suits will be H S C D
  """
  @spec create_deck(list(String.t()), list(String.t())) :: deck
  def create_deck(
        ranks \\ [
          "ace",
          "deuce",
          "trey",
          "sailboat",
          "five",
          "six",
          "seven",
          "snowman",
          "nine",
          "ten",
          "jack",
          "queen",
          "king"
        ],
        suits \\ ["hearts", "spades", "clubs", "diamonds"]
      ) do
    Enum.flat_map(suits, fn suit -> Enum.map(ranks, fn rank -> %{rank: rank, suit: suit} end) end)
  end

  @doc """
  It'll pass back a copy of the deck that's passed in, but with the order randomized
  """
  @spec shuffle(deck) :: deck
  def shuffle(unshuffled) do
    # first let's get the length of
    Enum.shuffle(unshuffled)
  end

  # @doc """
  # For practice (since I'm still new to elixir) I want to think about how I'd implement a shuffle myself
  # ... I looked it up though, and the real version just uses a sort.
  # I guess there's no way to shuffle in linear time when immutability is required...
  # None that I can think of anyway
  # """
  # def shuffle_my_way(unshuffled) do
  #   shuffle_my_way(unshuffled, length(unshuffled))
  # end

  # def shuffle_my_way(unshuffled, unshuffled_length, shuffled) when unshuffled_length == 0 do
  #   shuffled
  # end

  # def shuffle_my_way(unshuffled, unshuffled_length, shuffled // []) do

  # end

  @doc """
    move the requested number of cards from the origin deck to the hand
    return the new origin deck and the new hand (as they are after dealing)
  """
  @spec deal(deck, deck, integer) :: {deck, deck}
  def deal(origin_deck, hand, cards_requested) when cards_requested == 0 do
    {origin_deck, hand}
  end

  def deal(origin_deck, hand, cards_requested) do
    {new_hand_cards, remaining_origin_deck} = Enum.split(origin_deck, cards_requested)
    {remaining_origin_deck, hand ++ new_hand_cards}
  end

  @spec contains?(deck, card) :: boolean()
  def contains?(deck_to_search, target_card) do
    Enum.any?(deck_to_search, fn c -> c == target_card end)
  end

  @doc """
  For now, just gonna save one deck
  """
  @spec save(deck, String.t()) :: :ok | {:error, term() | :badarg | :terminated}
  def save(deck_of_cards, filename) do
    case File.open(filename, [:write]) do
      {:ok, file} ->
        serialized_deck = :erlang.term_to_binary(deck_of_cards)

        case IO.binwrite(file, serialized_deck) do
          :ok ->
            case File.close(file) do
              :ok -> :ok
              {:error, e} -> {:error, e}
            end

          {:error, e} ->
            {:error, e}
        end

      {:error, e} ->
        {:error, e}
    end
  end

  @doc """
  try to get deck of cards from file
  """
  @spec load(String.t()) :: {:ok, deck} | :error
  def load(filename) do
    case File.read(filename) do
      {:ok, bin} ->
        {:ok, :erlang.binary_to_term(bin)}

      {:error, _} ->
        :error
    end
  end
end
