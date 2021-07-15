class AppointmentSlotsController < ApplicationController
  before_action :set_appointment_slot, only: %i[ show edit update destroy ]

  # GET /appointment_slots or /appointment_slots.json
  def index
    @appointment_slots = AppointmentSlot.all
  end

  # GET /appointment_slots/1 or /appointment_slots/1.json
  def show
  end

  # GET /appointment_slots/new
  def new
    @appointment_slot = AppointmentSlot.new
  end

  # GET /appointment_slots/1/edit
  def edit
  end

  # POST /appointment_slots or /appointment_slots.json
  def create
    @appointment_slot = AppointmentSlot.new(appointment_slot_params)

    respond_to do |format|
      if @appointment_slot.save
        format.html { redirect_to @appointment_slot, notice: "Appointment slot was successfully created." }
        format.json { render :show, status: :created, location: @appointment_slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointment_slots/1 or /appointment_slots/1.json
  def update
    respond_to do |format|
      if @appointment_slot.update(appointment_slot_params)
        format.html { redirect_to @appointment_slot, notice: "Appointment slot was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment_slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_slots/1 or /appointment_slots/1.json
  def destroy
    @appointment_slot.destroy
    respond_to do |format|
      format.html { redirect_to appointment_slots_url, notice: "Appointment slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_slot
      @appointment_slot = AppointmentSlot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_slot_params
      params.require(:appointment_slot).permit(:time, :slot_id)
    end
end
