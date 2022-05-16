defmodule FoodDiaryWeb.Resolvers.User do
  alias FoodDiary.Users

  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)
end
