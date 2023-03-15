defmodule CarrinhoDeCompras do
  # Adiciona o item no inicio da lista
  def adicionar_item(item, lista_de_items) do
    [item | lista_de_items]
  end

  # Remove os elementos em comum, e retorna apenas os que existem do lado esquerdo
  def remover_item(item, lista_de_items) do
    lista_de_items -- [item]
  end

  # Juntando os elementos das duas listas (conjuntos)
  def misturar_listas(lista1, lista2) do
    lista1 ++ lista2
  end
end
