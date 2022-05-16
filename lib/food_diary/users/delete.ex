defmodule FoodDiary.Users.Delete do
  alias FoodDiary.{Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> Repo.delete(user)
    end
  end
end
