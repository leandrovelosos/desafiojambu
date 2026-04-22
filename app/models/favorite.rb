class Favorite < ApplicationRecord
  belongs_to :user
  # associa favorito a um usuário

  validates :name, presence: true
  validates :category, presence: true
  # garante que os campos não sejam vazios

  validates :name, uniqueness: {
    scope: [:user_id, :category],
    message: "já foi adicionado aos favoritos"
  }
  # impede duplicados para o mesmo usuário na mesma categoria
end