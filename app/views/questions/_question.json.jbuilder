json.extract! question, :id, :title, :description, :question_type_id, :survey_id, :min, :max, :placeholder, :created_at, :updated_at
json.url question_url(question, format: :json)
