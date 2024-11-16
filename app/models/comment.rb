class Comment < ApplicationRecord
  belongs_to :photo  # Relación con la foto
  belongs_to :user
  validates :content, presence: true  # Validación de contenido
end
