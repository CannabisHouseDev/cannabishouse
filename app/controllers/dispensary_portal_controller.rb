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

  def transfers_report
    @t = Transfer.all
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = ReportPdf.new(@t)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
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
  class ReportPdf < Prawn::Document
    def initialize(transfers)
      super()
      @transfers = transfers
      header
      text_content
      table_content
    end
  
    def header
      #This inserts an image in the pdf file and sets the size of the image
      image "#{Rails.root}/app/assets/images/logo.png", width: 100, height: 50
    end
  
    def text_content
      # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
      y_position = cursor - 50
  
      # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
      bounding_box([0, y_position], :width => 270, :height => 50) do
        text "#{I18n.t('.magazine.address')}", size: 15, style: :bold
        text "Dispensary Address"
      end
  
      bounding_box([300, y_position], :width => 270, :height => 50) do
        text "Oznaczenie Dyspensarium", size: 15, style: :bold
        text "ZDW-1"
      end
    end
  
    def table_content
      table(data_set, :header => true)
    end
    def data_set
      i = 0
      data = [[
        'LP.',
        'rodzaj operacji magazynowej', 
        'data zdarzenia', 
        'nr dok operacji', 
        'Imie i nazwisko wydajacego', 
        'signature', 
        'imie i nazwisko odbiorcy', 
        'rodzaj srodka lub produktu', 
        'nr serii',
        'ilosc szt/g', 
        'stan po operacji'
        ]]
      data += @transfers.map do |transfer, i|
        [i, "wydanie", "#{transfer.updated_at}", transfer.id, Profile.find_by(user_id: transfer.sender_id).first_name, 'podpis', Profile.find_by(user_id: transfer.reciever_id).first_name, 'rodzaj materialu', 'nr serii', transfer.weight, 'zostalo']
      end
    end
  end
end
