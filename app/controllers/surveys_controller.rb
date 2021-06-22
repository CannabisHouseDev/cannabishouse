class SurveysController < ApplicationController
  before_action :set_survey, only: %i[show edit update destroy hide]

  # GET /surveys or /surveys.json
  def index
    @surveys = Survey.where(hidden: false)
  end

  # GET /surveys/1 or /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys or /surveys.json
  def create
    @survey = Survey.new(survey_params)
    @survey.author = current_user
    byebug
    respond_to do |format|
      if @survey.save
        format.html { redirect_back fallback_location: authenticated_root_path, notice: "Survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { redirect_back fallback_location: authenticated_root_path, error: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_back fallback_location: authenticated_root_path, notice: "Survey was successfully updated." }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { redirect_back fallback_location: authenticated_root_path, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1 or /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: "Survey was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def hide
    @survey.hide
    respond_to do |format|
      format.html { redirect_back fallback_location: authenticated_root_path, error: 'Survey Deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      params.require(:survey).permit(:title, :description, :author)
    end
end
