defmodule FoodDiaryWeb.Resolvers.Meal do
  # alias Absinthe.Subscription
  alias FoodDiary.Meals
  # alias FoodDiaryWeb.Endpoint

  # def create(%{input: params}, _context) do
  #   with {:ok, meal} <- Meals.Create.call(params) do
  #     Subscription.publish(Endpoint, meal, new_meal: "new_meal_topic")
  #     {:ok, meal}
  #   else
  #     error -> error
  #   end
  # end

  def create(%{input: params}, _context), do: Meals.Create.call(params)
end
