# frozen_string_literal: true

class ParticipantPortalController < ApplicationController
  require "rqrcode"
  before_action :set_required_surveys, only: :steps

  def index
    @active = current_user.profile.active_study
    qr = RQRCode::QRCode.new(current_user.id.to_s, mode: :alphanumeric)
    @qr = qr.as_png(size: 400)
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def studies
    @studies = Study.all
  end

  def register
    StudyParticipation.find_or_create_by(study_id: params[:id], user_id: current_user.id)
    current_user.profile.register!
    redirect_to action: :steps
  end

  # A mini router just for the new onboarding process
  def steps
    case current_user.profile.aasm_state
    when 'fresh'
      redirect_to info_path
    when 'filled_info'
    when 'registered'
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
      redirect_to action: :book
    else
      redirect_to action: :index
    end
  end

  # transitions asm state to consented and goes back to steps
  def agree
    current_user.profile.consent!
    redirect_to action: :steps
  end

  def pay; end

  def process_payment
    @current_user.profile.pay!
    Cycle.create(user: @current_user, annual_paid_on: DateTime.now)
    redirect_to action: :steps
  end

  def book
    @slots = Slot.unscoped.group_by(&:day)
    @start_date = DateTime.now
    @end_date = DateTime.now + 30.days
  end

  def book_appointment
    slot = Slot.find(params[:id])
    date = DateTime.parse(params[:d]).change({ hour: slot.hours.to_i, min: slot.minutes.to_i })
    Appointment.find_or_create_by(participant: current_user, doctor: slot.doctor, time: date)
    current_user.profile.book!
    redirect_to action: :steps
  end

  # If the caller of this action sends a ref, it means we're in the onboarding process not filling out normal surveys
  def fill_survey
    if params[:ref]
      set_required_surveys
      @ref = params[:ref] # To choose which required survey's turn to answer is now out of the required_surveys array
    else
      set_filled
    end
    @fill = FilledSurvey.find(params[:id])
    @answers = @fill.survey.questions.map { |q| Answer.find_or_create_by(question_id: q.id, filled_survey_id: @fill.id) }.sort_by { |q| q.question.order }
    @answers.each do |a|
      a.update(option_id: a.question.options.first.id, content: a.question.options.first.name) unless a.option_id
    end
  end

  private

  def set_filled
    @surveys = Survey.where(hidden: false).map { |survey| FilledSurvey.find_or_create_by(survey_id: survey.id, user_id: current_user.id)}
  end

  def set_required_surveys
    id = current_user.id
    @surveys = [FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'pum')),
                FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'phq9')),
                FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'index')),
                FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'kssuk30')),
                FilledSurvey.find_or_create_by(user_id: id, survey: Survey.find_by(internal_name: 'ghq30'))]
  end
end
