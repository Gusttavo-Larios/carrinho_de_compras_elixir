defmodule CarrinhoDeCompras do
  @moduledoc """
    Disponibiliza funcoes para manipular carrinhos de compras
  """
  alias CarrinhoDeCompras.MyEnum

  @doc """
  Adicionar um item ao carrinho

  ## Parametros
    - item: %{id: id, nome: nome, valor: valor}
    - lista_de_produtos: [%{id: id, nome: nome, valor: valor}]

  ## Exemplo
    iex> CarrinhoDeCompras.adicionar_item(%{id: 2, nome: "TV", valor: 1000}, [%{id: 1, nome: "Geladeira", valor: 1500}])
    [%{id: 1, nome: "Geladeira", valor: 1500}, %{id: 2, nome: "TV", valor: 1000}]

  """
  def adicionar_item(%{id: id, nome: nome, valor: valor}, lista_de_produtos) do
    lista = lista_de_produtos ++ [%{id: id, nome: nome, valor: valor}]
    {:ok, lista}
  end

  def remover_item(lista_de_produtos, id) do
    lista = Enum.filter(lista_de_produtos, fn item -> item.id != id end)
    {:ok, lista}
  end

  def misturar_listas(lista1, lista2) do
    lista = lista1 ++ lista2
    {:ok, lista}
  end

  def obter_primerio_item_da_lista(lista_de_produtos) do
    lista = hd(lista_de_produtos)
    {:ok, lista}
  end

  def obter_outros_elementos_lista(lista_de_produtos) do
    lista = tl(lista_de_produtos)
    {:ok, lista}
  end

  def separar_lista(lista_de_produtos) do
    {_, hd} = obter_primerio_item_da_lista(lista_de_produtos)
    {_, tail} = obter_outros_elementos_lista(lista_de_produtos)

    %{:primeiro_item => hd, :resto_da_lista => tail}
  end

  # Pattern matching
  def ordenar_por_preco(lista_de_produtos, por_maior_preco: por_maior_preco) do
    lista =
      Enum.sort(lista_de_produtos, fn primeiro_item, segundo_item ->
        primeiro_item.valor > segundo_item.valor
      end)

    {:ok, lista}
  end

  def ordenar_por_preco(lista_de_produtos) do
    lista =
      Enum.sort(lista_de_produtos, fn primeiro_item, segundo_item ->
        primeiro_item.valor < segundo_item.valor
      end)

    {:ok, lista}
  end

  def obter_total_da_lista(lista_de_produtos) do
    quantidade_de_items = length(lista_de_produtos)

    valor_total = MyEnum.reduce_map_list(:valor, lista_de_produtos)

    {:ok,
     %{
       quantidade_de_items: quantidade_de_items,
       valor_total: valor_total
     }}
  end

  def obter_nome_do_produto(lista_de_produtos) do
    # comprehensions simples
    for item <- lista_de_produtos, do: item.nome
  end

  def obter_produtos_baratos(lista_de_produtos) do
    # comprehensions com filtro
    for item <- lista_de_produtos, item.valor < 900, do: item
  end

  def realizar_compra(lista_de_produtos, meio_de_pagamento) do
    {_, %{quantidade_de_items: quantidade_de_items, valor_total: valor_total}} =
      lista_de_produtos |> obter_total_da_lista()

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
