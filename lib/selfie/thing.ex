defmodule Selfie.Thing do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :rules]}
  embedded_schema do
    field :name, :string
    embeds_one :rules, Selfie.Rule, on_replace: :delete
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:name])
    |> cast_embed(:rules, required: true)
  end

  def params do
    %{
      name: "Paul",
      rules: %{
        __type__: :rules,
        condition: :or,
        rules: [
          %{
            __type__: :rule,
            field: "size",
            operator: "eq",
            value: "m"
          },
          %{
            __type__: :rule,
            field: "colour",
            operator: "eq",
            value: "blue"
          },
          %{
            __type__: :rules,
            condition: :and,
            rules: [
              %{
                __type__: :rule,
                field: "cheese",
                operator: "ne",
                value: "american"
              },
              %{
                __type__: :rule,
                field: "bread",
                operator: "ne",
                value: "white"
              }
            ]
          }
        ]
      }
    }
  end
end
