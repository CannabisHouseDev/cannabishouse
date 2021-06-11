# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  category         :integer
#  city             :string
#  country          :string
#  province         :integer
#  street1          :string
#  street2          :string
#  zip_code         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
class Address < ApplicationRecord
  has_paper_trail
  belongs_to :addressable, polymorphic: true
  validates :street1, :city, :province, :zip_code, :country, :category, presence: true
  validates :zip_code, format: { with: /\A(\d{2}-\d{3})/, message: I18n.t('active_record.attributes.address.zip_code') }

  enum province: %w[
    Dolnośląskie
    Kujawsko-Pomorskie
    Lubelskie
    Lubuskie
    Łódzkie
    Małopolskie
    Mazowieckie
    Opolskie
    Podkarpackie
    Podlaskie
    Pomorskie
    Śląskie
    Świętokrzyskie
    Warmińsko-Mazurskie
    Wielkopolskie
    Zachodnio-Pomorskie
  ]

  enum category: %w[
    Legal
    Shipping
    Communication
  ]
end
