# frozen_string_literal: true

class DispensaryPortalController < ApplicationController
  def index
    @material = Material.where(owner: current_user)
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
    material = Material.find(session[:material_selected])
    receiver = Profile.find(session[:current_participant]).user
    t = material.split(receiver, params[:amount].to_i)
    respond_to do |format|
      if t[0]
        format.html { render partial: 'dispensary_portal/partials/search', notice: "Material transferred", status: :ok }
      else
        format.html { render json: { error: true, message: t[1]}.to_json, status: :bad_request }
      end
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

  def add_to_cart
    OrderMaterial.create(material_id: @material.id, )
  end

  def report

  end
end
