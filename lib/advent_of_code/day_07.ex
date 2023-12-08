defmodule AdventOfCode.Day07 do
  @rank_order ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
  @rank_joker_order ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
  @joker "J"

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, stake] -> {String.graphemes(hand), String.to_integer(stake)} end)
    |> Enum.sort(fn a, b -> compare_hands(a, b, &calculate_hand/1, @rank_order) end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {{_, stake}, index}, acc -> (index + 1) * stake + acc end)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, stake] -> {String.graphemes(hand), String.to_integer(stake)} end)
    |> Enum.sort(fn a, b -> compare_hands(a, b, &calculate_joker_hand/1, @rank_joker_order) end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {{_, stake}, index}, acc -> (index + 1) * stake + acc end)
  end

  def compare_hands({hand1, _}, {hand2, _}, calculate_hand, rank_order) do
    score1 = calculate_hand.(hand1)
    score2 = calculate_hand.(hand2)

    if score1 == score2 do
      Enum.zip(hand1, hand2)
      |> Enum.reduce_while([], fn {a, b}, acc ->
        a = Enum.find_index(rank_order, fn x -> x == a end)
        b = Enum.find_index(rank_order, fn x -> x == b end)

        if a == b do
          {:cont, acc}
        else
          {:halt, a > b}
        end
      end)
    else
      score1 <= score2
    end
  end

  defp calculate_hand(hand) do
    hand_count =
      Enum.reduce(hand, %{}, fn card, acc ->
        Map.update(acc, card, 1, fn exist -> exist + 1 end)
      end)

    score_hand_count(hand_count)
  end

  defp calculate_joker_hand(hand) do
    hand_count =
      Enum.reduce(hand, %{}, fn card, acc ->
        Map.update(acc, card, 1, fn exist -> exist + 1 end)
      end)
      |> Kernel.then(fn count ->
        jokers = Map.get(count, @joker)

        if jokers == 5 do
          count
        else
          count =
            Map.delete(count, @joker)

          {highest, _} =
            Enum.max_by(count, fn {_, v} -> v end)

          Map.update(count, highest, 5, fn existing -> existing + (jokers || 0) end)
        end
      end)

    score_hand_count(hand_count)
  end

  defp score_hand_count(count) do
    size = Kernel.map_size(count)
    max = Map.values(count) |> Enum.max()

    case {max, size} do
      {5, _} -> 7
      {4, _} -> 6
      {3, size} when size == 2 -> 5
      {3, _} -> 4
      {2, size} when size == 3 -> 3
      {2, _} -> 2
      {1, _} -> 1
    end
  end
end
