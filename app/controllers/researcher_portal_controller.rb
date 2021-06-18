# frozen_string_literal: true

class ResearcherPortalController < ApplicationController
  def index
    questions = [
      {
        id: 1,
        survey: 12,
        type: 'short',
        label: 'short question',
        description: 'an example of a short question',
        placeholder: 'your answer here'
      },
      {
        id: 2,
        survey: 12,
        type: 'long',
        label: 'long question',
        description: 'an example of a long question',
        placeholder: 'your answer here'
      },
      {
        id: 3,
        survey: 12,
        type: 'number',
        label: 'number question',
        description: 'an example of a number question',
        min: 10,
        max: 100,
        step: 5,
        unit: 'days'
      },
      {
        id: 4,
        survey: 12,
        type: 'range',
        label: 'range question',
        description: 'an example of a range question',
        min: 10,
        max: 100,
        step: 2,
        unit: 'grams'
      },
      {
        id: 5,
        survey: 12,
        type: 'single',
        label: 'single choice question',
        description: 'an example of a single choice question',
        options: %w[option1 option2 option3]
      },
      {
        id: 6,
        survey: 12,
        type: 'multiple',
        label: 'multiple choice question',
        description: 'an example of a multiple choice question',
        options: %w[option1 option2 option3]
      },
      {
        id: 7,
        survey: 12,
        type: 'date',
        label: 'date question',
        description: 'an example of a date question',
        min: Time.now,
        max: Time.now + 1.months
      }
    ]
    @survey = { questions: questions }
  end
end
