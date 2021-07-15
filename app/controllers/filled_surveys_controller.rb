class FilledSurveysController < ApplicationController
  before_action :set_filled_survey, only: %i[ show edit update destroy ]

  # GET /filled_surveys or /filled_surveys.json
  def index
    @filled_surveys = FilledSurvey.all
  end

  # GET /filled_surveys/1 or /filled_surveys/1.json
  def show
  end

  # GET /filled_surveys/new
  def new
    @filled_survey = FilledSurvey.new
  end

  # GET /filled_surveys/1/edit
  def edit
  end

  # POST /filled_surveys or /filled_surveys.json
  def create
    @filled_survey = FilledSurvey.new(filled_survey_params)

    respond_to do |format|
      if @filled_survey.save
        format.html { redirect_to @filled_survey, notice: "Filled survey was successfully created." }
        format.json { render :show, status: :created, location: @filled_survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filled_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filled_surveys/1 or /filled_surveys/1.json
  def update
    respond_to do |format|
      if @filled_survey.update(filled_survey_params)
        update_answers
        update_state
        format.html { redirect_to authenticated_root_path, notice: "Survey Filled" }
        format.json { render :show, status: :ok, location: @filled_survey }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filled_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filled_surveys/1 or /filled_surveys/1.json
  def destroy
    @filled_survey.destroy
    respond_to do |format|
      format.html { redirect_to filled_surveys_url, notice: "Filled survey was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filled_survey
      @filled_survey = FilledSurvey.find(params[:id]) if params[:id]
    end

    # Only allow a list of trusted parameters through.
    def filled_survey_params
      params.require(:filled_survey).permit(:survey_id, :state, :user_id)
    end

    def update_state
      @filled_survey.update_score
      @filled_survey.update!(state: 'done')
      current_user.profile.fill_surveys(@filled_survey.user_id, @filled_survey.survey.study)
    end

    def update_answers
      answers = params.keys.filter { |k| k.ends_with? '_answer' }.map { |k| [Answer.find(k.split('_')[0]), params[k]] }
      answers.each do |answer|
        answer[0].update!(option_id: answer[1], content: QuestionOption.find(answer[1]).name)
      end
    end
end
