defmodule FoodDiary.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodDiary.User

  @categories [:dessert, :food, :drink]
  @fields [:description, :calories, :category, :user_id]

  schema "meals" do
    field :calories, :float
    field :category, Ecto.Enum, values: @categories
    field :description, :string

    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_number(:calories, greater_than: 0)
    |> validate_length(:description, min: 2)
    |> foreign_key_constraint(:user_id)
  end
end
