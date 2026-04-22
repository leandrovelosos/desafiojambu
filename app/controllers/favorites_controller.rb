class FavoritesController < ApplicationController
  before_action :require_login
  # 🔐 Garante que TODAS as ações exigem login

  def index
    @favorites = current_user.favorites
    # Agora usamos o usuário logado corretamente
      # Agrupa favoritos por categoria
    @grouped_favorites = current_user.favorites.group_by(&:category)
  end

  def create
    # Cria um novo favorito associado ao usuário logado
    favorite = current_user.favorites.new(
      name: params[:name],        # nome do item (ex: Luke Skywalker)
      category: params[:category],# categoria (people, planets, etc)
      url: params[:url]           # URL da API (ESSENCIAL para detalhes)
    )

    if favorite.save
      # Se salvar com sucesso
      redirect_to search_path(category: params[:category], query: params[:query]),
                notice: "Favorito adicionado!"
    else
      # Se der erro (ex: duplicado)
      redirect_to search_path(category: params[:category], query: params[:query]),
                alert: favorite.errors.full_messages.to_sentence
    end
  end

  def destroy
    # Busca o favorito apenas do usuário logado (segurança)
    favorite = current_user.favorites.find(params[:id])

    # Remove do banco
    favorite.destroy

    # Redireciona de volta com mensagem
    redirect_to favorites_path, notice: "Favorito removido com sucesso!"
  end

end