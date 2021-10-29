class Produto < ApplicationRecord

	belongs_to :departamento

	validates :quantidade, presence: true 
	validates :preco, presence: true 
	validates :descricao, presence: true 
	validates :nome, length: { minimum: 5}
end
