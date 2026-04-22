#service para consumir a API SWAPI (Star Wars API)
#base_uri → define a base da API
#get("/people/") → endpoint dinâmico
#query → permite busca por nome
#parsed_response["results"] → SWAPI sempre retorna os dados dentro de results

# Serviço responsável por consumir a API da SWAPI
class SwapiService
  include HTTParty

  base_uri 'https://swapi.dev/api'

  def self.search(category, query = nil, url = nil)

    # ⚠️ Opções para ignorar erro de certificado (apenas dev)
    options = {
      verify: false
      # Desabilita verificação SSL (resolve erro de certificado expirado)
    }

    if url
      # Quando vem paginação (URL completa da API)
      response = HTTParty.get(url, options)
    else
      # Busca normal com categoria e query
      response = get("/#{category}/", query: { search: query }, **options)
    end

    # Retorna estrutura padronizada
    {
      results: response["results"],   # lista de resultados
      next: response["next"],         # próxima página
      previous: response["previous"]  # página anterior
    }
  end

  def self.find(url)
    # Faz requisição direta para a URL do item
    response = HTTParty.get(url, verify: false)

    response.parsed_response
    # retorna todos os dados do item
  end
end