# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  before_action :set_appointment, only: %i[appointments done cancel]
  before_action :set_appointments, only: %i[index appointments]

  def index
  end

  def appointments
  end

  def evaluations; end

  def calendar
    @start_time = 8
    @end_time = 20
  end

  def done
    if @appointment.update(state: :done)
      redirect_to doctor_portal_path, notice: 'Appointment updated'
    else
      redirect_to appointments_path(@appointment), alert: 'Unable to update appointment.'
    end
  end

  def cancel
    if @appointment.update(state: :cancelled)
      redirect_to doctor_portal_path, notice: 'Appointment updated'
    else
      redirect_to appointments_path(@appointment), alert: 'Unable to update appointment.'
    end
  end

  private

  def set_appointments
    @appointments = Appointment.includes(participant: :profile).where(state: :pending).order(time: :asc)
  end
  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end
end
