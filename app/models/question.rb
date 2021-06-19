class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :survey
  has_many :question_options
end
