defmodule FoodDiaryWeb.Schema.Types.Meal do
  use Absinthe.Schema.Notation

  enum :category do
    value :food
    value :drink
    value :dessert
  end

  @desc "Logic meal representation"
  object :meal do
    field :id, non_null(:id)
    field :description, non_null(:string)
    field :calories, non_null(:float)
    field :category, non_null(:category)
  end
end
