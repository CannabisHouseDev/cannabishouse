# frozen_string_literal: true

class ResearcherPortalController < ApplicationController
  before_action :set_surveys, only: %w[surveys survey_edit show_questions index]
  before_action :set_studies, only: %w[index show_studies show_studies]
  before_action :set_survey, only: %w[survey_edit show_questions add_question]

  # Studies

  def add_study
    Study.create(user_id: current_user.id, title: 'New Study')
    redirect_to action: :index
  end

  def show_studies
    @selected = Study.find(params[:id])
  end

  def edit_study
    byebug
    Study.find(params[:id]).update!(params[:study])
  end

  # Surveys
  def surveys; end

  def survey_edit; end

  def add_survey
    Survey.create(author: current_user, title: 'New Survey')
    back 'Added new survey'
  end

  # Questions
  def show_questions
    @questions = Question.where(survey_id: @survey.id).order(created_at: :asc)
    @question = Question.new(survey_id: @survey.id, question_type_id: QuestionType.find_by(name: 'short').id)
  end

  def add_question
    Question.create(question_type_id: params[:question][:question_type], survey_id: @survey.id)
    back 'Added new question'
  end

  def update_question
    question = Question.find(params[:id])
    params.require(:question)[:options_attributes].permit!
    options = params[:question][:options_attributes]
    if question.update(question_update_param)
      options.each do |option|
        o = QuestionOption.find(option[1][:id]).update(option[1])
      end
      back 'Question updated'
    else
      back question.errors
    end
  end

  def remove_question
    Question.find(params[:id]).destroy
    back 'removed question'
  end
  def add_option
    QuestionOption.create(question_id: params[:id])
    back 'Added new option'
  end

  def remove_option
    QuestionOption.find(params[:id]).destroy
    back 'Removed option'
  end

  private

  def set_surveys
    @surveys = Survey.where(author: current_user, hidden: false)
  end

  def set_survey
    @survey = Survey.find(params[:survey].to_i)
  end

  def survey_params
    params.permit(:survey).permit(:study)
  end

  def question_update_param
    params.require(:question).permit(:title, :description, :question_type_id, :min, :max, options_attributes: [:id, :name, :display, :_update])
  end

  def set_studies
    @studies = Study.where(user_id: current_user.id)
  end

  def back(message)
    respond_to do |format|
      format.html { redirect_back fallback_location: authenticated_root_path, notice: message }
      format.json { head :no_content }
    end
  end
end
