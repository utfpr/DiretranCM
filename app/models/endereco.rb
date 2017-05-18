class Endereco < ApplicationRecord
  belongs_to :pessoa

  validates :cidade,
	presence: {message: ": deve ser preenchido"},
	length: {maximum: 50, message: ": maximo de 50 digitos"}

  validates :bairro,
	presence: {message: ": deve ser preenchido"},
	length: {maximum: 255, message: ": maximo de 255 digitos"}

  validates :logradouro,
	presence: {message: ": deve ser preenchido"},
	length: {maximum: 255, message: ": maximo de 255 digitos"}

  validates :numero,
	presence: {message: ": deve ser preenchido"},
	length: {maximum: 5, message: ": maximo de 5 digitos"},
	numericality: {only_integer: true, message: ": deve ser preenchido com números"}

  validates :complemento,
	presence: {message: ": deve ser preenchido"},
	length: {maximum: 255, message: ": maximo de 255 digitos"}

  validates :pessoa_id,
  uniqueness: true
  
end
