defmodule FoodDiary.Repo do
  use Ecto.Repo,
    otp_app: :food_diary,
    adapter: Ecto.Adapters.Postgres
end
