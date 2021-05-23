# frozen_string_literal: true

module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[agreement_1 agreement_2])
  end
end

DeviseController.include DevisePermittedParameters
