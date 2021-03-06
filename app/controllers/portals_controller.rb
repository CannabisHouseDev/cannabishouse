# frozen_string_literal: true

class PortalsController < ApplicationController
  before_action :authenticate_user!
  def role_router
    redirect_to landing_page and return unless current_user
    case current_user.profile.role
    when 'user'
      redirect_to steps_path and return
    when 'participant'
      redirect_to steps_path and return
    when 'dispensary'
      redirect_to dispensary_portal_path and return
    when 'doctor'
      redirect_to doctor_portal_path and return
    when 'researcher'
      redirect_to researcher_portal_path and return
    when 'admin'
      redirect_to '/administrator' and return
    end
    head :ok
  end
end
