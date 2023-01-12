defmodule Mailtrap.Email.Mailbox do
  @moduledoc """
  Mailbox  struct

  Why mailbox?
  https://www.rfc-editor.org/rfc/rfc5322#section-3.4
  """

  @type t :: %__MODULE__{
          name: String.t() | nil,
          email: String.t()
        }

  defstruct name: nil,
            email: nil

  @doc """
  Builds Mailbox struct

  ## Examples
    iex> Mailtrap.Email.Mailbox.build(nil, "jane.doe@example.com")
    %Mailtrap.Email.Mailbox{email: "jane.doe@example.com"}

    iex> Mailtrap.Email.Mailbox.build("", "jane.doe@example.com")
    %Mailtrap.Email.Mailbox{email: "jane.doe@example.com"}

    iex> Mailtrap.Email.Mailbox.build("Jane", "jane.doe@example.com")
    %Mailtrap.Email.Mailbox{email: "jane.doe@example.com", name: "Jane"}
  """
  @spec build(String.t() | nil, String.t()) :: __MODULE__.t()
  def build(nil, address), do: %__MODULE__{email: address}
  def build("", address), do: %__MODULE__{email: address}

  def build(name, address) do
    %__MODULE__{email: address, name: name}
  end
end

defimpl Jason.Encoder, for: [Mailtrap.Email.Mailbox] do
  def encode(struct, opts) do
    struct
    |> Map.from_struct()
    |> Enum.map(& &1)
    |> Enum.filter(fn {_k, v} -> !is_nil(v) end)
    |> Jason.Encode.keyword(opts)
  end
end
