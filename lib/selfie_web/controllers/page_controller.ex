defmodule SelfieWeb.PageController do
  use SelfieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
