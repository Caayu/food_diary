# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodDiary.Repo.insert!(%FoodDiary.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FoodDiary.{Meal, Repo, User}

user1_params = %{email: "rafael@myemail.com", name: "Rafael"}
user2_params = %{email: "john@myemail.com", name: "Joao"}

meal1_params = %{description: "Pizza de calabresa", calories: 373.3, category: :food}
meal2_params = %{description: "Copo de refri de cola", calories: 80.0, category: :drink}
meal3_params = %{description: "Fatia de torta de banana", calories: 250.55, category: :dessert}

# Inserting users
%User{id: user1_id} = user1_params |> User.changeset() |> Repo.insert!()
%User{id: user2_id} = user2_params |> User.changeset() |> Repo.insert!()

# Inserting meals to user1
meal1_params |> Map.put(:user_id, user1_id) |> Meal.changeset() |> Repo.insert!()
meal2_params |> Map.put(:user_id, user1_id) |> Meal.changeset() |> Repo.insert!()

# Inserting meals to user2
meal1_params |> Map.put(:user_id, user2_id) |> Meal.changeset() |> Repo.insert!()
meal2_params |> Map.put(:user_id, user2_id) |> Meal.changeset() |> Repo.insert!()
meal3_params |> Map.put(:user_id, user2_id) |> Meal.changeset() |> Repo.insert!()
