defmodule SelfieWeb.SurfaceLive2 do
  @moduledoc """
  This does not work.

  I think what is happening is the outer form is being passed to the component
  so it tries to render the same form recursively forever.
  """
  use SelfieWeb, :surface_live_view

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
    <h2>Surface and Surface.Component, hoping the Context is passed through magically</h2>
    <div>
      <Form for={@changeset} change="change">
        <FieldContext name={:name}>
          <Label text="Name" /> <TextInput />
        </FieldContext>
        <SelfieWeb.RulesComponent2 />
      </Form>
    </div>
    """
  end
end
