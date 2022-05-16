defmodule FoodDiaryWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias FoodDiaryWeb.Resolvers.User, as: UsersResolver

  import_types FoodDiaryWeb.Schema.Types.Meal
  import_types FoodDiaryWeb.Schema.Types.User

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)

      resolve &UsersResolver.get/2
    end
  end

  object :root_mutation do
    @desc "Create a new user"
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UsersResolver.create/2
      middleware TranslateErrors
    end

    @desc "Deletes user"
    field :delete_user, type: :user do
      arg :id, non_null(:id)

      resolve &UsersResolver.delete/2
    end
  end
end
