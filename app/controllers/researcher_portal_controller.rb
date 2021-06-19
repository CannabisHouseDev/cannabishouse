# frozen_string_literal: true

class ResearcherPortalController < ApplicationController
  before_action :set_surveys, only: %w[index surveys survey_edit]
  before_action :set_survey, only: %w[survey_edit show_questions add_question]
  def index; end

  def add_survey
    Survey.create(author: current_user, title: 'New Survey')
    respond_to do |format|
      format.html { redirect_back fallback_location: authenticated_root_path }
      format.json { head :no_content }
    end
  end

  def surveys; end

  def survey_edit; end

  def show_questions
    @questions = Question.where(survey_id: @survey.id)
  end

  def add_question
    Question.create(type: params[:type], survey_id: @survey.id)
  end

  private

  def set_surveys
    @surveys = Survey.where(author: current_user, hidden: false)
  end

  def set_survey
     @survey = Survey.where(survey_id: params[:survey])
  end
end
