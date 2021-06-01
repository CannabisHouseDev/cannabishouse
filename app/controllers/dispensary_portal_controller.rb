# frozen_string_literal: true

class DispensaryPortalController < ApplicationController
  def index; end

  def billing; end

  def stock; end

  def search
    @profile = Profile.find_by(user_id: params[:code])
    render partial: 'dispensary_portal/partials/participant'
  end

  def transfer; end
end
