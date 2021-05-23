# frozen_string_literal: true

require 'administrate/field/base'

class RichTextField < Administrate::Field::Base
  def to_s
    data
  end
end
