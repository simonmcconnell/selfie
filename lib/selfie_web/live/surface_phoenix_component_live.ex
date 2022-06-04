defmodule SelfieWeb.SurfacePhoenixComponentLive do
    @moduledoc """
  This works.
  """
  use SelfieWeb, :surface_live_view

  alias Surface.Components.Context
  alias Surface.Components.Form
  alias Surface.Components.Form.{FieldContext, Label, TextInput}

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
    ~F"""
    <h2>Surface and Phoenix.Component, passing the form as an assign</h2>
    <div>
      <Form for={@changeset} change="change">
        <FieldContext name={:name}>
          <Label text="Name" />
          <TextInput />
        </FieldContext>
        <Context get={Surface.Components.Form, form: f}>
          <SelfieWeb.LiveViewLive.rules form={f} />
        </Context>
      </Form>
    </div>
    """
  end
end
