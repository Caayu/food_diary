defmodule FoodDiaryWeb.SchemaTest do
  use FoodDiaryWeb.ConnCase, async: true
  use FoodDiaryWeb.SubscriptionCase

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

  describe "users mutation" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            email: "caio@banana.com", name: "Caio Henrique"
          }) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "email" => "caio@banana.com",
                   "name" => "Caio Henrique"
                 }
               }
             } == response
    end
  end

  describe "subscriptions" do
    test "meals subscription", %{socket: socket} do
      params = %{email: "caio@email.com", name: "Caio"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      mutation = """
        mutation {
          createMeal(input: {
            userId: #{user_id}, description: "Pizza de Frango", calories: 370.50, category: FOOD
          }) {
            description,
            calories,
            category
          }
        }
      """

      subscription = """
        subscription {
          newMeal {
            description
          }
        }
      """

      # Setup Subscription
      socket_ref = push_doc(socket, subscription)
      assert_reply socket_ref, :ok, %{subscriptionId: subscription_id}

      # Setup Mutation
      socket_ref = push_doc(socket, mutation)
      assert_reply socket_ref, :ok, mutation_response

      expected_mutation_response = %{
        data: %{
          "createMeal" => %{
            "calories" => 370.5,
            "category" => "FOOD",
            "description" => "Pizza de Frango"
          }
        }
      }

      expected_subscription_response = %{
        result: %{data: %{"newMeal" => %{"description" => "Pizza de Frango"}}},
        subscriptionId: subscription_id
      }

      assert mutation_response == expected_mutation_response

      assert_push "subscription:data", subscription_response
      assert subscription_response == expected_subscription_response
    end
  end
end
