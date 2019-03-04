defmodule CampusTalks.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :end, :naive_datetime
    field :image, :string
    field :speaker_name, :string
    field :start, :naive_datetime
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(talk, attrs) do
    talk
    |> cast(attrs, [:title, :start, :end, :image, :url, :speaker_name])
    |> validate_required([:title, :start, :end, :url])
  end
end
