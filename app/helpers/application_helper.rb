# app/helpers/application_helper.rb

module ApplicationHelper
  # 🔹 Traduz valores simples (ex: "male" → "Masculino")
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
      "blue" => "Azul"
    }

    # Retorna tradução se existir, senão retorna o valor original
    translations[value.to_s.downcase] || value
  end

  # 🔹 Traduz labels (ex: "hair_color" → "Cor do cabelo")
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
      "homeworld" => "Planeta natal"
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