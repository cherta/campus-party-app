defmodule CampusTalks.Repo do
  use Ecto.Repo,
    otp_app: :campus_talks,
    adapter: Ecto.Adapters.Postgres
end
