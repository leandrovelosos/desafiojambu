# app/helpers/application_helper.rb

module ApplicationHelper
  # traduz as informaçoes (ex: "male" → "Masculino")
  def translate_value(value)
    return "Não informado" if value.blank?

    translations = {
      "male" => "Masculino",
      "female" => "Feminino",
      "n/a" => "Não aplicável",
      "none" => "Nenhum",
      "unknown" => "Desconhecido",
      "fair" => "Clara",
      "blond" => "Loiro",
      "blue" => "Azul",
      "superheated" => "Superaquecida",
      "mountains" => "Montanhas",
      "volcanoes" => "Vulcões",
      "rocky deserts" => "Desertos rochosos",
      "arid" => "Árido",
      "desert" => "Deserto",
      "indefinite" => "Indefinida",
      "sentient" => "Senciente",
    }

    # Retorna tradução se existir, senão retorna o valor original
    translations[value.to_s.downcase] || value
  end

  # traduz ao rotulos das informaçoes dos objetos, se faltar alguma tem que por aqui
  def translate_label(key)
    translations = {
      "name" => "Nome",
      "height" => "Altura",
      "mass" => "Peso",
      "hair_color" => "Cor do cabelo",
      "skin_color" => "Cor da pele",
      "eye_color" => "Cor dos olhos",
      "birth_year" => "Ano de nascimento",
      "gender" => "Gênero",
      "films" => "Filmes",
      "vehicles" => "Veículos",
      "starships" => "Naves",
      "species" => "Espécies",
      "homeworld" => "Planeta natal",
      "rotation_period" => "Período de rotação",
      "orbital_period" => "Período orbital",
      "diameter" => "Diâmetro",
      "climate" => "Clima",
      "gravity" => "Gravidade",
      "terrain" => "Terreno",
      "surface_water" => "Água superficial",
      "population" => "População",
      "residents" => "Habitantes",
      "model" => "Modelo",
      "manufacturer" => "Fabricante",
      "cost_in_credits" => "Custo em créditos",
      "length" => "Comprimento",
      "max_atmosphering_speed" => "Velocidade máxima na atmosfera",
      "crew" => "Tripulação",
      "passengers" => "Passageiros",
      "cargo_capacity" => "Capacidade de carga",
      "consumables" => "Suprimentos",
      "hyperdrive_rating" => "Classificação do hiperespaço",
      "starship_class" => "Classe da nave",
      "pilots" => "Pilotos",
      "title" => "Título",
      "episode" => "Episódio",
      "opening_crawl" => "Resumo inicial",
      "director" => "Diretor",
      "producer" => "Produtor",
      "release_date" => "Data de lançamento",
      "characters" => "Personagens",
      "planets" => "Planetas",
      "people" => "Pessoas",
      "eye_color" => "Cor dos olhos",
      "average_height" => "Altura média",
      "classification" => "Classificação",
      "designation" => "Designação",
      "skin_colors" => "Cor da pele",
      "hair_colors" => "Cor do cabelo",
      "average_lifespan" => "Expectativa de vida média"

    }

    translations[key] || key.humanize
  end

  # 🔹 Formata valores com inteligência (UNIDADES + tradução)
  def format_value(key, value)
    return "Não informado" if value.blank?

    case key
    when "height"
      value == "unknown" ? "Desconhecido" : "#{value} cm"
      # altura sempre em cm

    when "mass"
      value == "unknown" ? "Desconhecido" : "#{value} kg"
      # peso em kg

    else
      # 🔸 fallback padrão

      if value.to_s.include?(",")
        # trata valores compostos
        value.split(",").map { |v| translate_value(v.strip) }.join(", ")
      else
        # valor simples
        translate_value(value)
      end
    end
  end
end