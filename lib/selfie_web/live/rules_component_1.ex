defmodule SelfieWeb.RulesComponent1 do
  use SelfieWeb, :surface_component

  alias Surface.Components.Form.{
    FieldContext,
    HiddenInput,
    HiddenInputs,
    Inputs,
    Label,
    TextInput
  }

  prop form, :struct, required: true

  def render(assigns) do
    ~F"""
    <Inputs form={@form} for={:rules} :let={form: f}>
      <HiddenInputs /> <HiddenInput field={:__type__} /> {#case Ecto.Changeset.get_change(f.source, :__type__)}
        {#match :rule}
          RULE
          <FieldContext name={:field}>
            <Label text="Field" /> <TextInput />
          </FieldContext>
          <FieldContext name={:operator}>
            <Label text="Operator" /> <TextInput />
          </FieldContext>
          <FieldContext name={:value}>
            <Label text="Value" /> <TextInput />
          </FieldContext>
        {#match :rules}
          RULES
          <FieldContext name={:condition}>
            <Label text="Condition" /> <TextInput />
          </FieldContext>
          <SelfieWeb.RulesComponent1 form={f} />
      {/case}
    </Inputs>
    """
  end
end
