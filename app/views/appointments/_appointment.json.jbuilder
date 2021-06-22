json.extract! appointment, :id, :time, :doctor_id, :participant_id, :state, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
