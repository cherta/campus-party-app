defmodule CampusTalks.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :image, :string
      add :url, :string
      add :speaker_name, :string

      timestamps()
    end

  end
end
