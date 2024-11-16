class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy  # Relación con comentarios
  validates :caption, presence: true  # Validación de caption
  validates :image_url, presence: true, format: { with: URI::regexp(%w[http https]) }
end


  # validates :image_url, presence: true, url: true  # Validación para la URL