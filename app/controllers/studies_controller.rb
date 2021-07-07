class StudiesController < ApplicationController
  before_action :set_study, only: %i[ show edit update destroy ]

  # GET /studies or /studies.json
  def index
    @studies = Study.all
  end

  # GET /studies/1 or /studies/1.json
  def show
  end

  # GET /studies/new
  def new
    @study = Study.new
  end

  # GET /studies/1/edit
  def edit
  end

  # POST /studies or /studies.json
  def create
    @study = Study.new(study_params)

    respond_to do |format|
      if @study.save
        format.html { redirect_to @study, notice: "Study was successfully created." }
        format.json { render :show, status: :created, location: @study }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studies/1 or /studies/1.json
  def update
    respond_to do |format|
      if @study.update(study_params)
        format.html { redirect_back fallback_location: authenticated_root_path, notice: 'Study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_back fallback_location: authenticated_root_path, error: 'Could not update study' }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studies/1 or /studies/1.json
  def destroy
    @study.destroy
    respond_to do |format|
      format.html { redirect_to studies_url, notice: "Study was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def study_params
      params.require(:study).permit(:title, :description, :user_id, :max, :fee, :cycle)
    end
end
