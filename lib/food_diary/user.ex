defmodule FoodDiary.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodDiary.Meal

  @fields [:email, :name]

  schema "users" do
    field :email, :string
    field :name, :string

    has_many :meals, Meal

    timestamps()
  end

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
