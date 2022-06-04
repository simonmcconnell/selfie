defmodule SelfieWeb.LiveViewLive do
  use SelfieWeb, :live_view

  def mount(_params, _session, socket) do
    changeset =
      Selfie.Thing.params()
      |> Selfie.Thing.changeset()
      |> IO.inspect(label: "changeset")

    {:ok, assign(socket, :changeset, changeset)}
  end

  def handle_event("change", %{"thing" => params}, socket) do
    IO.inspect(params, label: "change")

    {:noreply, update(socket, :changeset, &Selfie.Thing.changeset(&1, params))}
  end

  def render(assigns) do
    ~H"""
    <h2>LiveView & Phoenix.Component</h2>
    <div>
      <.form let={f} for={@changeset} phx-change="change">
        <%= label f, :name, "Name" %>
        <%= text_input f, :name %>
        <.rules form={f} />
      </.form>
    </div>
    """
  end

  def rules(assigns) do
    ~H"""
    <%= for f <- inputs_for(@form, :rules) do %>
      <%= hidden_inputs_for(f) %>
      <%= hidden_input(f, :__type__) %>
      <%= case Ecto.Changeset.get_change(f.source, :__type__) do %>
        <% :rule -> %>
          RULE
          <%= label f, :field, "Field" %>
          <%= text_input f, :field %>

          <%= label f, :field, "Operator" %>
          <%= text_input f, :operator %>

          <%= label f, :field, "Value" %>
          <%= text_input f, :value %>
        <% :rules -> %>
          RULES
          <%= label f, :condition, "Condition" %>
          <%= text_input f, :condition %>

          <.rules form={f} />
      <% end %>
    <% end %>
    """
  end
end
