defmodule FoodDiaryWeb.SubscriptionCase do
  use ExUnit.CaseTemplate

  alias Absinthe.Phoenix.SubscriptionTest

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import FoodDiaryWeb.ChannelCase

      use SubscriptionTest, schema: FoodDiaryWeb.Schema

      # The default endpoint for testing
      @endpoint FoodDiaryWeb.Endpoint

      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(FoodDiaryWeb.FoodSocket, %{})
        {:ok, socket} = SubscriptionTest.join_absinthe(socket)

        {:ok, socket: socket}
      end
    end
  end
end
