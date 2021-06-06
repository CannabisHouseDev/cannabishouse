# frozen_string_literal: true

class PortalsController < ApplicationController
  before_action :authenticate_user!
  def role_router
    redirect_to landing_page and return if !current_user
    redirect_to onboarding_path and return unless current_user.onboarded?
    case current_user.profile.role
    when 'user'
      redirect_to participant_portal_path and return
    when 'participant'
      redirect_to participant_portal_path and return
    when 'dispensary'
      redirect_to dispensary_portal_path and return
    when 'doctor'
      redirect_to doctor_portal_path and return
    when 'researcher'
      redirect_to researcher_portal_path and return
    end
    head :ok
  end
end
