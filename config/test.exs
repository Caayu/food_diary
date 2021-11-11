import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :food_diary, FoodDiary.Repo,
  username: "postgres",
  password: "postgres",
  database: "food_diary_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_diary, FoodDiaryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "lYigBhuk/Ou8DExfNSLcRg5e4b+IHG6kdR/zD5AhtUUeouLyotja00ETi7bV74xa",
  server: false

# In test we don't send emails.
config :food_diary, FoodDiary.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
