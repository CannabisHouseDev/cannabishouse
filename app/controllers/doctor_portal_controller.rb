# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  before_action :set_appointments, only: %i[index appointments]
  before_action :set_evaluations, only: %i[index evaluations]
  def index; end

  def appointments
    @selected = params[:id] || nil
  end

  def evaluations
    @selected = params[:id] || nil
  end

  def calendar
    @start_time = 8
    @end_time = 20
  end

  private

  def set_appointments
    @appointments = Appointment.where(doctor_id: current_user.id, state: 'pending').order(time: :asc)
  end

  def set_evaluations
    @evaluations = Appointment.where(doctor_id: current_user.id, state: 'done').order(time: :asc)
  end
end
