json.extract! filled_survey, :id, :survey_id, :state, :user_id, :created_at, :updated_at
json.url filled_survey_url(filled_survey, format: :json)
