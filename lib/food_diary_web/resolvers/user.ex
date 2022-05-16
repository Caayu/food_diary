defmodule FoodDiaryWeb.Resolvers.User do
  alias FoodDiary.Users

  def create(%{input: params}, _context), do: Users.Create.call(params)
  def delete(%{id: id}, _context), do: Users.Delete.call(id)
  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)
end
