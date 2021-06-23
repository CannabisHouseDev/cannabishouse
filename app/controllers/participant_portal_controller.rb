# frozen_string_literal: true

class ParticipantPortalController < ApplicationController
  before_action :set_filled, only: %w[surveys fill_survey]
  def index
    redirect_to :steps if current_user.profile.aasm_state == 'filled_info'
  end

  def agree
    current_user.profile.consent!
    redirect_to :steps
  end

  def steps
    redirect_to :book if current_user.profile.aasm_state == 'paid'
  end

  def surveys; end

  def fill_survey
    @fill = FilledSurvey.find(params[:id])
    @answers = @fill.survey.questions.map { |q| Answer.find_or_create_by(question_id: q.id, filled_survey_id: @fill.id) }
  end

  private

  def set_filled
    @surveys = Survey.where(hidden: false).map { |survey| FilledSurvey.find_or_create_by(survey_id: survey.id, user_id: current_user.id)}
  end
end
