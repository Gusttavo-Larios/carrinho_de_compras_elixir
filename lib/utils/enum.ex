defmodule CarrinhoDeCompras.MyEnum do
  @moduledoc false

  import Enum

  def reduce_map_list(chave, lista_de_items) do
    lista_de_valores = Enum.map(lista_de_items, & &1[chave])

    Enum.reduce(lista_de_valores, fn primeiro_item, segundo_item ->
      primeiro_item + segundo_item
    end)
  end
end
