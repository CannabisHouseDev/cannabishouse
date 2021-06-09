# frozen_string_literal: true

class DispensaryPortalController < ApplicationController
  def index
    @material = Material.all.take(6)
  end

  def search
    render partial: 'dispensary_portal/partials/search'
  end

  def participant
    @profile = Profile.find_by(user_id: params[:code])
    session[:current_participant] = @profile.id
    render partial: 'dispensary_portal/partials/participant'
  end

  def material_choice
    render partial: 'dispensary_portal/partials/material_choice'
  end

  def transfer
    session[:material_selected] = params[:material]
    @profile = Profile.find(session[:current_participant])
    render partial: 'dispensary_portal/partials/transfer'
  end

  def finalize
    # Need to add tranfer failsafe measures before going live
    material = Material.find(session[:material_selected])
    reciever = Profile.find(session[:current_participant]).user
    material.split(reciever, params[:amount].to_i)
    respond_to do |format|
      format.html { render partial: 'dispensary_portal/partials/search', notice: "Material transferred" }
      format.json { render json: {message: "success"}.to_json, status: :created}
    end
  end

  def transfers
    @transfers = if params[:start] && params[:end]
                  Transfer.where(sender: current_user, created_at: params[:start].to_date..params[:end].to_date)
                 elsif params[:start]
                  Transfer.where(sender: current_user, created_at: params[:start].to_date..Date.today)
                 else
                  Transfer.where(sender: current_user, created_at: (Date.today.prev_month)..Date.today)
                end
    @start = (params[:start].to_date if params[:start]) || Date.today.prev_month
    @end = (params[:end].to_date if params[:end]) || Date.today
  end

  def stock; end

  def warehouse
    @material = Material.where(owner: Profile.find_by(role: 'warehouse').user.id)
    render partial: 'dispensary_portal/partials/warehouse_stock'
  end

  def order
    @material = Material.find(params[:material])
    render partial: 'dispensary_portal/partials/material_order'
  end
end
