defmodule CampusTalksWeb.Schema do
  use Absinthe.Schema

  alias CampusTalks.Resolvers

  import_types(Absinthe.Type.Custom)

  @desc "A talk"
  object :talk do
    field :id, :id
    field :title, :string
    field :speaker_name, :string
    field :start, :datetime
    field :end, :datetime
    field :image, :string
    field :url, :string
  end

  query do
    @desc "Get all talks"
    field :talks, list_of(:talk) do
      resolve(&Resolvers.Talks.list/3)
    end
  end
end
