# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  def index; end

  def appointments; end

  def calendar
    @start_time = 8
    @end_time = 20
  end
end
