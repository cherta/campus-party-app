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
      arg(:date, non_null(:date))
      resolve(&Resolvers.Talks.list/3)
    end

    @desc "Get a single talk"
    field :talk, :talk do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Talks.find_by_id/3)
    end
  end

  input_object :update_talk_input do
    field(:title, :string)
    field(:speaker_name, :string)
    field(:start, :datetime)
    field(:end, :datetime)
    field(:image, :string)
    field(:url, :string)
  end

  mutation do
    @desc "Update a talk"
    field :update_talk, type: :talk do
      arg(:id, non_null(:id))
      arg(:talk, non_null(:update_talk_input))

      resolve(&Resolvers.Talks.update_talk/3)
    end
  end
end
