# frozen_string_literal: true

class ParticipantPortalController < ApplicationController
  def index; end

  def surveys
    s = Survey.where(hidden: false)
    @surveys = s.map { |survey| FilledSurvey.find_or_create_by(survey_id: survey.id, participant: current_user)}
  end
end
