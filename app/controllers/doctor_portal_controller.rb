# frozen_string_literal: true

class DoctorPortalController < ApplicationController
  def index
    @start_time = 8
    @end_time = 20
  end

  def appointments; end

  def calendar; end
end
