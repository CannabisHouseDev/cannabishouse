module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:agreement_1, :agreement_2, :agreement_3, :agreement_4])
  end
end

DeviseController.send :include, DevisePermittedParameters
