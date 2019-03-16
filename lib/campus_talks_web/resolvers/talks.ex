defmodule CampusTalks.Resolvers.Talks do
  alias CampusTalks.Repo
  alias CampusTalks.Talk

  import Ecto.Query

  def list(_parent, %{date: date}, _resolution) do
    start_date = %DateTime{
      year: date.year,
      month: date.month,
      day: date.day,
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: {0, 0},
      zone_abbr: DateTime.utc_now().zone_abbr,
      utc_offset: DateTime.utc_now().utc_offset,
      std_offset: DateTime.utc_now().std_offset,
      time_zone: DateTime.utc_now().time_zone
    }

    end_date = %DateTime{
      year: date.year,
      month: date.month,
      day: date.day,
      hour: 23,
      minute: 59,
      second: 59,
      microsecond: {0, 0},
      zone_abbr: DateTime.utc_now().zone_abbr,
      utc_offset: DateTime.utc_now().utc_offset,
      std_offset: DateTime.utc_now().std_offset,
      time_zone: DateTime.utc_now().time_zone
    }

    {:ok,
     Talk
     |> where([t], t.start >= ^start_date and t.start <= ^end_date)
     |> order_by([t], asc: t.start)
     |> Repo.all()}
  end

  def find_by_id(_parent, %{id: id}, _resolution) do
    {:ok,
     Talk
     |> where([t], t.id == ^id)
     |> Repo.one()}
  end

  def update_talk(_parent, attrs, _resolution) do
    case Repo.get(Talk, attrs[:id]) do
      nil ->
        {:error, "Cannot find the Talk (#{attrs[:id]})"}

      talk ->
        changeset = Talk.changeset(talk, attrs[:talk])

        case Repo.update(changeset) do
          {:ok, talk} -> {:ok, talk}
          {:error, _changeset} -> {:error, "There was an error"}
        end
    end
  end
end
