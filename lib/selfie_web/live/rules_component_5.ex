defmodule SelfieWeb.RulesComponent5 do
  use SelfieWeb, :surface_component

  alias Surface.Components.Context

  alias Surface.Components.Form.{
    FieldContext,
    HiddenInput,
    HiddenInputs,
    Inputs,
    Label,
    TextInput
  }

  def render(assigns) do
    IO.inspect(assigns)

    ~F"""
    <Context get={Surface.Components.Form, form: f}>
      <Inputs form={f} for={:rules} :let={form: f}>
        <HiddenInputs />
        <HiddenInput field={:__type__} />
        {#case Ecto.Changeset.get_change(f.source, :__type__)}
          {#match :rule}
            RULE
            <FieldContext name={:field}>
              <Label text="Field" />
              <TextInput />
            </FieldContext>
            <FieldContext name={:opertaor}>
              <Label text="Operator" />
              <TextInput />
            </FieldContext>
            <FieldContext name={:value}>
              <Label text="Value" />
              <TextInput />
            </FieldContext>
          {#match :rules}
            RULES
            <FieldContext name={:condition}>
              <Label text="Condition" />
              <TextInput />
            </FieldContext>
            {!--
            gets stuck in infinite loop trying to render this
            because it is using the parent form...?
            --}
            <Context put={Surface.Components.Form, form: f}>
              <SelfieWeb.RulesComponent5 />
            </Context>
        {/case}
      </Inputs>
    </Context>
    """
  end
end
