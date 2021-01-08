class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def show
    @page = Page.friendly.find_by(slug: params[:id]) if params[:id]
    raise ActionController::RoutingError.new('Not Found') unless @page
  	set_meta_tags(title: @page.title)
  end
  
  private
    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :body, :show_in_menu, :slug)
    end
end
