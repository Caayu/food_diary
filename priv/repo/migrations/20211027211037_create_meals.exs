defmodule FoodDiary.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :description, :string
      add :calories, :float
      add :category, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:meals, [:user_id])
  end
end
