defmodule Selfie.Rule do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:condition, :rules]}
  embedded_schema do
    field :__type__, Ecto.Enum, values: [:rule, :rules]
    # rule
    field :field, :string
    field :operator, :string
    field :value, :string

    # rules
    field :condition, Ecto.Enum, values: [:and, :or]
    embeds_many :rules, __MODULE__, on_replace: :delete
  end

  def new_rule(field, operator \\ "eq", value \\ "") do
    %{
      __type__: :rule,
      field: field,
      operator: operator,
      value: value
    }
  end

  def new_rules(condition \\ :and) do
    %{
      __type__: :rules,
      condition: condition,
      rules: [
        new_rule("size")
      ]
    }
  end

  def changeset(data, %{__type__: :rule} = params) do
    rule_changeset(data, params)
  end

  def changeset(data, %{"__type__" => "rule"} = params) do
    rule_changeset(data, params)
  end

  def changeset(data, %{__type__: :rules} = params) do
    rules_changeset(data, params)
  end

  def changeset(data, %{"__type__" => "rules"} = params) do
    rules_changeset(data, params)
  end

  def changeset(data, params) do
    IO.inspect(params, label: "changeset w/o type set!")

    params =
      case Map.keys(params) |> List.first() do
        string when is_binary(string) -> Map.put(params, "__type__", "rule")
        _ -> Map.put(params, :__type__, :rule)
      end

    changeset(data, params)
  end

  defp rule_changeset(data, params) do
    data
    |> cast(params, [:__type__, :field, :operator, :value])
  end

  def rules_changeset(data, params) do
    data
    |> cast(params, [:__type__, :condition])
    |> cast_embed(:rules, required: true)
    |> validate_inclusion(:condition, Ecto.Enum.values(__MODULE__, :condition))
  end
end
