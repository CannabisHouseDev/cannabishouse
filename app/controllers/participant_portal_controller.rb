# frozen_string_literal: true

class ParticipantPortalController < ApplicationController
  require "rqrcode"
  before_action :set_filled, only: %i[fill_survey steps]

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
      redirect_to action: :pay
    when 'paid'
      redirect_to action: :studies
    when 'registered'
      redirect_to action: :agree
    when 'consented'
      redirect_to action: :fill_survey
    when 'filled_all_surveys'
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
    @start_date = Date.today
    @end_date = Date.today.next_month
    (@start_date..@end_date).each do |d|
      Slot.where(day: d.wday).each do |s|
        AppointmentSlot.find_or_create_by(slot: s, time: d.to_datetime.change({hour: s.time.hour, min: s.time.min}))
      end
    end
    @slots = AppointmentSlot.where(booked: false).group_by { |as| as.time.wday }
  end

  def book_appointment
    appointment_slot = AppointmentSlot.find(params[:id])
    date = appointment_slot.time
    Appointment.find_or_create_by(participant: current_user, doctor: appointment_slot.slot.doctor, time: date)
    current_user.profile.book!
    appointment_slot.update!(booked: true)
    redirect_to action: :steps
  end

  def fill_survey
    @selected = params[:id] ? FilledSurvey.find(params[:id]) : @surveys.first
    @answers = @selected.survey.questions.map { |q| Answer.find_or_create_by(question_id: q.id, filled_survey_id: @selected.id) }
    @answers.sort_by { |q| q.question.order }
  end

  private

  def set_filled
    if current_user.profile.active_study
      @surveys = current_user.profile.active_study.study.surveys.map { |survey| FilledSurvey.find_or_create_by(survey: survey, user_id: current_user.id) }.select { |f| f.state != 'done' }
    end
  end
end
