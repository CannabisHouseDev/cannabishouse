# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:landing, :about, :media]

  def landing; end
  def about; end
  def media; end

  def onboarding
    redirect_to authenticated_root_path and return if current_user.onboarded?

    @profile = current_user.profile || Profile.new(current_user)
    render 'onboarding'
  end

  def show
    @page = Page.friendly.find_by(slug: params[:id]) if params[:id]
    raise ActionController::RoutingError, 'Not Found' unless @page

    set_meta_tags(title: @page.title)
  end

  private

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:title, :body, :show_in_menu, :slug, :inner, :position)
  end
end
