defmodule CarrinhoDeCompras do
  # Coleções
  #   [] -> listas (encadeadas)
  #   {} -> tuplas
  #   [{:atom, variável},{:atom, variável}] -> lista de palavras chave
  #   [atom: variável, atom: variável] -> lista de palavras chave
  #   %{key => value, key => value} ou %{atom: value, atom: value} -> mapa
  #     %{map | atom: value} -> atualizar chave já existente no mapa
  #     Map.put(mapa, :atom, value) -> inserir uma nova chave no mapa
  # Enum
  #   Módulo para se trabalhar com enumeráveis (coleções, com a exceção de tuplas)
  # Módulos
  #   alias, import (filtro), require, use
  # Sigils

  alias CarrinhoDeCompras.MyEnum

  def adicionar_item(%{id: id, nome: nome, valor: valor}, lista_de_compras) do
    lista = lista_de_compras ++ [%{id: id, nome: nome, valor: valor}]
    {:ok, lista}
  end

  def remover_item(lista_de_compras, id) do
    lista = Enum.filter(lista_de_compras, fn item -> item.id != id end)
    {:ok, lista}
  end

  def misturar_listas(lista1, lista2) do
    lista = lista1 ++ lista2
    {:ok, lista}
  end

  def obter_primerio_item_da_lista(lista_de_compras) do
    lista = hd(lista_de_compras)
    {:ok, lista}
  end

  def obter_outros_elementos_lista(lista_de_compras) do
    lista = tl(lista_de_compras)
    {:ok, lista}
  end

  def separar_lista(lista_de_compras) do
    {_, hd} = obter_primerio_item_da_lista(lista_de_compras)
    {_, tail} = obter_outros_elementos_lista(lista_de_compras)

    %{:primeiro_item => hd, :resto_da_lista => tail}
  end

  # Pattern matching
  def ordenar_por_preco(lista_de_compras, por_maior_preco: por_maior_preco) do
    lista =
      Enum.sort(lista_de_compras, fn primeiro_item, segundo_item ->
        primeiro_item.valor > segundo_item.valor
      end)

    {:ok, lista}
  end

  def ordenar_por_preco(lista_de_compras) do
    lista =
      Enum.sort(lista_de_compras, fn primeiro_item, segundo_item ->
        primeiro_item.valor < segundo_item.valor
      end)

    {:ok, lista}
  end

  def obter_total_da_lista(lista_de_compras) do
    quantidade_de_items = length(lista_de_compras)

    valor_total = MyEnum.reduce_map_list(:valor, lista_de_compras)

    {:ok,
     %{
       quantidade_de_items: quantidade_de_items,
       valor_total: valor_total
     }}
  end

  def realizar_compra(lista_de_compras, meio_de_pagamento) do
    {_, %{quantidade_de_items: quantidade_de_items, valor_total: valor_total}} =
      lista_de_compras |> obter_total_da_lista()

      message = ~s/Compra realizada com sucesso. Valor: #{valor_total}/

    # if, unless, case, cond e with
    cond do
      valor_total < 500 && meio_de_pagamento != "Debito" ->
        {:error, %{message: "Selecione o debito como meio de pagamento!"}}

      valor_total >= 500 && valor_total <= 1000 && meio_de_pagamento != "Credito" ->
        {:error, %{message: "Selecione o credito como meio de pagamento!"}}

      true ->
        {:ok, %{message: message}}
    end
  end
end
