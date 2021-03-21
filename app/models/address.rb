class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :street1, :city, :province, :zip_code, :country, :category, presence: true
  validates :zip_code, format: { with: /\A(\d{2}-\d{3})/, message: I18n.t('active_record.attributes.address.zip_code') }
	
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

	enum category: [
		"Legal",
		"Shipping",
		"Communication"
	]
end
