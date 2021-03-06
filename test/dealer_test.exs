defmodule TwentyOne.DealerTest do
	use ExUnit.Case, async: true
	alias TwentyOne.{Dealer, Player}
	
	setup do
		{:ok, dealer} = Dealer.start_link
		{:ok, player} = Player.start_link(:dealer_test_player)
		{:ok, dealer: dealer, player: player}
	end
	
	test "dealer collects players", %{dealer: dealer, player: player} do
		assert Dealer.players(dealer) == []
		Dealer.add_player(dealer, player)
		assert Dealer.players(dealer) == [player]
	end

	test "adding player then play", %{dealer: dealer, player: player} do
		Dealer.add_player(dealer, player)
		cards = Player.reveal(player)
		assert is_list(cards)
		assert Enum.empty?(cards)
		results = Dealer.play(dealer)
		assert is_list results
	end

	test "can play for more than one round", %{dealer: dealer, player: player} do
		Dealer.add_player(dealer, player)
		results = Dealer.play(dealer, 5)
		assert is_list results
		assert 5 == length(results)
	end
end
