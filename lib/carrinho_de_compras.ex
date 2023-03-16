defmodule CarrinhoDeCompras do
  # Coleções
  #   [] -> listas (encadeadas)
  #   {} -> tuplas
  #   [{:atom, variável},{:atom, variável}] -> lista de palavras chave
  #   [atom: variável, atom: variável] -> lista de palavras chave
  #   %{key => value, key => value} ou %{atom: value, atom: value} -> mapa
  #     %{map | atom: value} -> atualizar chave já existente no mapa
  #     Map.put(mapa, :atom, value) -> inserir uma nova chave no mapa

  # Adiciona o item no inicio da lista
  def adicionar_item([item: item, lista_de_items: lista_de_items]) do
    # [item | lista_de_items]
    lista = lista_de_items ++ [item]
    {:ok, lista}
  end

  # def adicionar_item(_item, [1, 2, 3, 4, 5]) do
  #   {:error, [mensagem: "Valores nulos não podem ser adicionandos á lista"]}
  # end

  # Remove os elementos em comum, e retorna apenas os que existem do lado esquerdo
  def remover_item(item, lista_de_items) do
    lista = lista_de_items -- [item]
    {:ok, lista}
  end

  # Juntando os elementos das duas listas (conjuntos)
  def misturar_listas(lista1, lista2) do
    lista = lista1 ++ lista2
    {:ok, lista}
  end

  def obter_primerio_item_da_lista(lista_de_items) do
    # [hd | _] = lista_de_items
    lista = hd(lista_de_items)
    {:ok, lista}
  end

  def obter_outros_elementos_lista(lista_de_items) do
    # [_ | tl] = lista_de_items
    lista = tl(lista_de_items)
    {:ok, lista}
  end

  def separar_lista(lista_de_items) do
    {_, hd} = obter_primerio_item_da_lista(lista_de_items)
    {_, tail} = obter_outros_elementos_lista(lista_de_items)

    %{:primeiro_item => hd, :resto_da_lista => tail}
  end
end
