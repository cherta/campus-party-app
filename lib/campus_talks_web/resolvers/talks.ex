defmodule CampusTalks.Resolvers.Talks do
  alias CampusTalks.Repo
  alias CampusTalks.Talk

  def list(_parent, _args, _resolution) do
    {:ok, Repo.all(Talk)}
  end
end
