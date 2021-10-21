use Mix.Config

config :balenax,
  http_client: Balenax.Http.MockClient,
  username: "test_user",
  password: "test_password"
