defmodule FoodDiary.Users.Get do
  alias FoodDiary.{Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, Repo.preload(user, :meals)}
    end
  end
end
