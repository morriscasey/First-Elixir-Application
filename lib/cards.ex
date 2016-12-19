defmodule Cards do
@moduledoc """
  Provides methods for creating and handling a deck of cards
"""
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values =["Ace", "Two", "Three","Four","Five","Six","Seven","Eight","Nine", "Ten","Jack", "Queen", "King"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  @doc """
    Determines whether a deck contains a given card

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and remainder of the deck. The `hand_size`
    argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, amount_Of_Cards) do
    Enum.split(deck, amount_Of_Cards)
  end

  def save(deck, filename) do
    # Calling erlang method to convert deck to binary object
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      # : and name together(:*name*) is called an Atom similar to string, but codify error messages.
      # Comparing and assigning to either binary or reason depending on the outcome.
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # _ + name(_*name*) ignores variable even though required for pattern matching.
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    # |> pipes return value to next method. Similar to pipes in Linux
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
