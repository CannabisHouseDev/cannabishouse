# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!

  def landing; end

  def onboarding
    @profile = current_user.profile || Profile.new(current_user)
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
