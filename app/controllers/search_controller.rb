class SearchController < ApplicationController
  def index
    @category = params[:category]
    @query = params[:query]
    @page_url = params[:page_url]
    # page_url será usado para paginação

    if @category.present?
      data = SwapiService.search(@category, @query, @page_url)

      @results = data[:results]
      # lista de resultados

      @next_page = data[:next]
      # URL da próxima página

      @prev_page = data[:previous]
      # URL da página anterior
    end
  end

  def show
    @url = params[:url]
    # pega a URL enviada na rota

    if @url.blank?
      # evita erro se URL estiver ausente
      redirect_to search_path, alert: "Item inválido"
      return
    end

    @item = SwapiService.find(@url)
  end

  #sugestões de busca tipo do youtube
  def suggestions
    query = params[:query]
    category = params[:category] || "people"

    return render json: [] if query.blank?

    # chama a API (mesma estrutura do index)
    data = SwapiService.search(category, query)

    # usa símbolo (consistente com index)
    results = data[:results] || []

    # extrai nomes
    names = results.map { |item| item["name"] }

    # limita quantidade (melhor UX)
    render json: names.first(5)
  end
end