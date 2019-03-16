defmodule Mix.Tasks.Import do
  use Mix.Task
  import Mix.Ecto
  import Mix.EctoSQL

  @shortdoc "Imports all campus party talks into the db"

  @base_url "https://campuse.ro"
  @talks_url "#{@base_url}/events/campus-party-punta-del-este-2019/talk"

  defp get_talk_image(html) do
    html
    |> Floki.find(".activity-hero img")
    |> Floki.attribute("src")
    |> List.first()
  end

  defp parse_time!(time) do
    str_time =
      time
      |> String.replace("Feb.", "March")
      |> String.replace("p.m.", "pm")
      |> String.replace("a.m.", "am")
      |> String.replace("noon", "12 pm")
      |> String.replace("midnight", "00 am")

    try do
      case str_time |> Timex.parse("{Mfull} {D}, {YYYY}, {h12} {am}") do
        {:ok, result} -> result
        {:error, _} -> Timex.parse!(str_time, "{Mfull} {D}, {YYYY}, {h12}:{m} {am}")
      end
    rescue
      _ -> throw("Impossible to parse #{str_time}")
    end
  end

  defp get_talk_description(html) do
    html |> Floki.find(".ident-25") |> List.first() |> Floki.raw_html()
  end

  defp get_talk_title(html) do
    title =
      html
      |> Floki.find(".blue-box .title")
      |> Floki.text()
      |> String.split("|")
      |> List.first()

    case title do
      nil -> ""
      data -> String.trim(data)
    end
  end

  defp get_speaker_name(html) do
    name =
      html
      |> Floki.find(".blue-box .title")
      |> Floki.text()
      |> String.split("|")
      |> Enum.at(1)

    case name do
      nil -> ""
      data -> String.trim(data)
    end
  end

  defp get_talk_start(html) do
    html
    |> Floki.find(".metadata span")
    |> List.first()
    |> Floki.text()
    |> String.replace("p.m.", "pm")
    |> String.replace("a.m.", "am")
    |> String.replace("noon", "12 pm")
    |> parse_time!
  end

  defp get_talk_end(html) do
    html
    |> Floki.find(".metadata span")
    |> Enum.at(1)
    |> Floki.text()
    |> parse_time!
  end

  defp get_url(html) do
    url =
      html
      |> Floki.find(".header a")
      |> Floki.attribute("href")
      |> List.first()

    @base_url <> url
  end

  defp get_talk_data(url) do
    case HTTPoison.get(url, "accept-language": "en,es-US") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok,
         %{
           title: get_talk_title(body),
           speaker_name: get_speaker_name(body),
           start: get_talk_start(body),
           end: get_talk_end(body),
           description: get_talk_description(body),
           url: url,
           image: get_talk_image(body)
         }}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, url <> " is invalid"}

      {:error, _} ->
        {:error, "Error visiting " <> url}
    end
  end

  defp get_page(number) do
    case HTTPoison.get("#{@talks_url}?page=#{number}", "accept-language": "en,es-US") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Floki.find("#profile-activities-panel #events-grid .card")
        |> Enum.map(fn html ->
          case html |> get_url |> get_talk_data do
            {:ok, result} -> result
            {:error, _} -> %{}
          end
        end)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Mix.shell().info("Page not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Mix.shell().info("There was an error " <> reason)
    end
  end

  def start_ecto do
    repos = parse_repo([])

    Enum.each(repos, fn repo ->
      ensure_repo(repo, [])
      {:ok, _pid, _apps} = ensure_started(repo, [])
    end)
  end

  def run(_) do
    HTTPoison.start()
    start_ecto()
    pages = [1, 2, 3, 4, 5]

    pages
    |> Enum.flat_map(&get_page/1)
    |> Enum.map(fn attrs -> CampusTalks.Talk.changeset(%CampusTalks.Talk{}, attrs) end)
    |> Enum.map(fn changeset -> CampusTalks.Repo.insert!(changeset) end)

    Mix.shell().info("All talks imported")
  end
end
