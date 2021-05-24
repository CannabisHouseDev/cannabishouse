# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, except: 'landing'

  def landing; end

  def onboarding
    @profile = current_user.profile || Profile.new(current_user)
  end

  def participant
    render 'pages/participant/index'
  end

  def dispensary
    render 'pages/dispensary/index'
  end

  def doctor
    render 'pages/doctor/index'
  end

  def researcher
    render 'pages/researcher/index'
  end

  def show
    @page = Page.friendly.find_by(slug: params[:id]) if params[:id]
    raise ActionController::RoutingError, 'Not Found' unless @page

    set_meta_tags(title: @page.title)
  end

  def role_router
    redirect_to onboarding_path if !current_user.onboarded? and return
    case current_user.profile.role
    when "user"
      redirect_to participant_path and return
    when "participant"
      redirect_to participant_path and return
    when "dispensary"
      redirect_to dispensary_path and return
    when "doctor"
      redirect_to doctor_path and return
    when "researcher"
      redirect_to researcher_path and return
    end
    head :ok
  end

  private

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:title, :body, :show_in_menu, :slug, :inner, :position)
  end
end
