# frozen_string_literal: true

class DispensaryPortalController < ApplicationController
  def index; end

  def billing; end

  def stock; end

  def search
    render partial: 'dispensary_portal/partials/search'
  end

  def participant
    @profile = Profile.find_by(user_id: params[:code])
    render partial: 'dispensary_portal/partials/participant'
  end

  def material_choice
    render partial: 'dispensary_portal/partials/material_choice'
  end

  def transfer
    @material_id = params[:material]
    render partial: 'dispensary_portal/partials/transfer'
  end
end
