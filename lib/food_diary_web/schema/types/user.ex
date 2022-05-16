defmodule FoodDiaryWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "Logic user representation"
  object :user do
    field :id, non_null(:id), description: "Users id, needs to be an integer."
    field :name, non_null(:string)
    field :email, non_null(:string)
  end
end
