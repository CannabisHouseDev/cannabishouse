class ScoreSurveyJob < ApplicationJob
  queue_as :default

  def perform(*id)
    survey = FilledSurvey.find(id[0])
    survey.update_score
    survey.update!(state: 'done')
  end
end
