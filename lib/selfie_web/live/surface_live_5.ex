defmodule SelfieWeb.SurfaceLive5 do
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
    <h2>Surface and Surface.Component, get & put Context (incl. field), component gets Context</h2>
    <div>
      <Form for={@changeset} change="change">
        <FieldContext name={:name}>
          <Label text="Name" />
          <TextInput />
        </FieldContext>
        <Context get={Surface.Components.Form, form: f}>
          <Context
          put={Surface.Components.Form, form: f}
          put={Surface.Components.Form, field: :rules}
          >
            <SelfieWeb.RulesComponent2 />
          </Context>
        </Context>
      </Form>
    </div>
    """
  end
end
