# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  before_action :set_appointments, only: %i[index appointments]
  before_action :set_evaluations, only: %i[index evaluations]
  before_action :set_workday, only: %i[calendar spread_slots add_slot]
  def index
    flash.now[:error] = params[:flash][:error] if params[:flash] && params[:flash][:error]
  end

  def appointments
    @selected = params[:id] || nil
  end

  def evaluations
    @selected = params[:id] || @evaluations.first.id
    set_required_surveys
    no_scores
  end

  def calendar
    spread_slots
  end

  def remove_slot
    slot = Slot.find(params[:id])
    slot.appointment_slots.each do |as|
      as.destroy
    end
    slot.destroy
    redirect_to action: :calendar
  end

  def add_slot
    time = DateTime.now.utc.change({ hour: params[:hours].to_i, min: params[:minutes].to_i })
    Slot.find_or_create_by(user_id: current_user.id,
                           day: params[:day].to_i,
                           time: time)
    redirect_to action: :calendar
  end

  def appointment_done
    appointment = Appointment.find(params[:id])
    appointment.state = 'done'
    appointment.save!
    redirect_to action: :evaluations
  end

  def appointment_cancel
    appointment = Appointment.find(params[:id])
    appointment.state = 'cancelled'
    appointment.save!
    redirect_to action: :appointments
  end

  def evaluate
    s = Appointment.find(params[:id].to_i)
    s.participant.profile.set_quota(params[:dry].to_i, params[:oil].to_i, params[:risk], true)
    s.update!(state: 'evaluated')
    redirect_to action: :evaluations
  end

  def reject
    s = Appointment.find(params[:id].to_i)
    s.participant.set_quota(0, 0, 0, 0, false)
    redirect_to action: :evaluations
  end

  private

  def set_workday
    @start_time = 8
    @end_time = 20
  end

  def set_appointments
    @appointments = Appointment.where(doctor_id: current_user.id, state: 'pending').order(time: :desc)
  end

  def set_evaluations
    @evaluations = Appointment.where(doctor_id: current_user.id, state: 'done').order(time: :desc)
  end

  def set_required_surveys
    @surveys = [FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'pum')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'phq9')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'index')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'kssuk30')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'ghq30'))]
  end

  def no_scores
    if @surveys.include? nil
      flash[:error] = 'Could not fetch user scores, please contact support'
      redirect_to action: :index
    end
  end

  def spread_slots
    @slots = []
    slots = Slot.where(user_id: current_user.id).order(day: :asc).group_by(&:day).to_a
    slots = slots.map do |slot|
      [slot[0], slot[1].map { |s| [(((s.hours - @start_time.to_f) * 2) + (s.minutes.zero? ? 0 : 1)).to_i, s.booked, s.id] }]
    end
    (0..6).each do |i|
      @slots << if !slots.detect { |s| s.include? i }.nil?
                  slots.detect { |s| s.include? i }[1]
                else
                  []
                end
    end
  end
end
