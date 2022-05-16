defmodule FoodDiaryWeb.Resolvers.Meal do
  alias Absinthe.Subscription
  alias FoodDiary.Meals
  alias FoodDiaryWeb.Endpoint

  def create(%{input: params}, _context) do
    {:ok, meal} = Meals.Create.call(params)

    Subscription.publish(Endpoint, meal, new_meal: "new_meal_topic")

    {:ok, meal}
  end
end
