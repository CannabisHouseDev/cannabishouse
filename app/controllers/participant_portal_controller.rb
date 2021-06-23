# frozen_string_literal: true

class ParticipantPortalController < ApplicationController
  before_action :set_filled, only: :steps
  def index; end

  # A mini router just for the new onboarding process
  def steps
    case current_user.profile.aasm_state
    when 'fresh'
      redirect_to info_path
    when 'filled_info'
    when 'consented'
    when 'filled_first_survey'
    when 'filled_second_survey'
    when 'filled_third_survey'
    when 'filled_fourth_survey'
    when 'filled_fifth_survey'
      render 'steps'
    when 'filled_all_surveys'
      render action: :pay
    when 'paid'
      render action: :book
    else
      render action: :index
    end
  end

  def pay; end
  def book; end

  def fill_survey
    if params[:ref]
      set_required_surveys
      @ref = params[:ref].to_i - 1
    else
      set_filled
    end
    @fill = FilledSurvey.find(params[:id])
    @answers = @fill.survey.questions.map { |q| Answer.find_or_create_by(question_id: q.id, filled_survey_id: @fill.id) }
  end

  private

  def set_filled
    @surveys = Survey.where(hidden: false).map { |survey| FilledSurvey.find_or_create_by(survey_id: survey.id, user_id: current_user.id)}
  end

  def set_required_surveys
    @surveys = [FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: current_user.id, survey: Survey.find_by(internal_name: 'bMAST'))]
  end
end
