class QuestionOptionsController < ApplicationController
  before_action :set_question_option, only: %i[ show edit update destroy ]

  # GET /question_options or /question_options.json
  def index
    @question_options = QuestionOption.all
  end

  # GET /question_options/1 or /question_options/1.json
  def show
  end

  # GET /question_options/new
  def new
    @question_option = QuestionOption.new
  end

  # GET /question_options/1/edit
  def edit
  end

  # POST /question_options or /question_options.json
  def create
    @question_option = QuestionOption.new(question_option_params)

    respond_to do |format|
      if @question_option.save
        format.html { redirect_to @question_option, notice: "Question option was successfully created." }
        format.json { render :show, status: :created, location: @question_option }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_options/1 or /question_options/1.json
  def update
    respond_to do |format|
      if @question_option.update(question_option_params)
        format.html { redirect_to @question_option, notice: "Question option was successfully updated." }
        format.json { render :show, status: :ok, location: @question_option }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_options/1 or /question_options/1.json
  def destroy
    @question_option.destroy
    respond_to do |format|
      format.html { redirect_to question_options_url, notice: "Question option was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_option
      @question_option = QuestionOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_option_params
      params.require(:question_option).permit(:name, :question_id)
    end
end
