defmodule FoodDiaryWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)
    end
  end
end
