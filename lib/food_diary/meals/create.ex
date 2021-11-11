defmodule FoodDiary.Meals.Create do
  alias FoodDiary.{Repo, Meal}

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
  end
end
