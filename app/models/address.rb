class Address < ApplicationRecord
  belongs_to :user
  validates :street1, :city, :province, :zip_code, :country, :type, presence: true
  validates :zip_code, format: { with: /(\d{2}-\d{3})/, message: 	"Twój kod pocztowy ma format 00-000" }
	
  enum province: [
		"Dolnośląskie",
		"Kujawsko-Pomorskie",
		"Lubelskie",
		"Lubuskie",
		"Łódzkie",
		"Małopolskie",
		"Mazowieckie",
		"Opolskie",
		"Podkarpackie",
		"Podlaskie",
		"Pomorskie",
		"Śląskie",
		"Świętokrzyskie",
		"Warmińsko-Mazurskie",
		"Wielkopolskie",
		"Zachodnio-Pomorskie" 
  ]

	enum type: [
		"Legal",
		"Shipping"
	]
end
