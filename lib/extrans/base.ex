defmodule ExTrans.Base do
  import HTTPoison
  import Poison

  @csrf_header "X-Transmission-Session-Id"

  def url do
    Application.get_env(:extrans, :base_url)
  end

  def csrf_token do
    try do
      case :ets.lookup(:extrans, @csrf_header) do
        [{@csrf_header, val}] -> val
        [] -> ""
      end
    rescue
      e in ArgumentError -> 
        :ets.new(:extrans, [:named_table])
        ""
    end
  end

  def call(method) do
    call(method, %{})
  end

  def call(method, args = %{}) do
    headers = [{@csrf_header, csrf_token()}]
    data = %{
      "method" => method,
      "arguments" => args,
    } |> Poison.encode!

    case HTTPoison.post(url, data, headers) do
      {:ok, body} ->
        body
          |> handle_response(method)
          |> unwrap_msg
      err ->
        err
    end
  end

  def handle_response(resp = %HTTPoison.Response{status_code: 409}, mthd) do
    token = get_csrf(resp)
    :ets.insert(:extrans, {@csrf_header, token})
    call(mthd)
  end

  def handle_response(%HTTPoison.Response{status_code: 200, body: body}, _) do
    Poison.decode! body
  end

  def unwrap_msg(msg = %{"result" => "success"}) do
    {:ok, msg["arguments"]}
  end

  def unwrap_msg(%{"result" => err}) do
    {:error, err}
  end

  def unwrap_msg({:error, err}) do
    {:error, err}
  end

  def get_csrf(resp) do
    Enum.filter(resp.headers, fn({k,_}) -> k == @csrf_header end)
    |> hd
    |> elem(1)
  end
end