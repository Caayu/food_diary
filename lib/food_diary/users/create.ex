defmodule FoodDiary.Users.Create do
  alias FoodDiary.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
