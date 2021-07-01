# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  before_action :set_appointments, only: %i[index appointments]
  before_action :set_evaluations, only: %i[index evaluations]
  def index; end

  def appointments
    @selected = params[:id] || nil
  end

  def evaluations
    @selected = params[:id] || @evaluations.first.id
    set_required_surveys
  end

  def calendar
    @start_time = 8
    @end_time = 20
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

  def set_appointments
    @appointments = Appointment.where(doctor_id: current_user.id, state: 'pending').order(time: :asc)
  end

  def set_evaluations
    @evaluations = Appointment.where(doctor_id: current_user.id, state: 'done').order(time: :asc)
  end

  def set_required_surveys
    @surveys = [FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'bMAST')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'pum')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'phq9')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'index')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'kssuk30')),
                FilledSurvey.find_by(user_id: Appointment.find(@selected).participant.id, survey: Survey.find_by(internal_name: 'ghq30'))]
  end
end
