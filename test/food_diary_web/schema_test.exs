defmodule FoodDiaryWeb.SchemaTest do
  use FoodDiaryWeb.ConnCase, async: true

  alias FoodDiary.User
  alias FoodDiary.Users

  describe "users query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "caio@email.com", name: "Caio"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      query = """
      {
        user(id: #{user_id}) {
          name,
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => %{"email" => "caio@email.com", "name" => "Caio"}}
      }

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end

    test "when the user does not exist, returns an error", %{conn: conn} do
      query = """
      {
        user(id: 123456) {
          name,
          email
        }
      }
      """

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "User not found",
            "path" => ["user"]
          }
        ]
      }

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end
  end
end
