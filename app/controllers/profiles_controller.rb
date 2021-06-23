# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_profile, only: %i[show edit update destroy]

  # GET /profiles
  # GET /profiles.json
  def index; end

  # GET /profiles/1
  # GET /profiles/1.json
  def show; end

  # GET /profiles/new
  def new; end

  # GET /profiles/1/edit
  def edit; end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = @user.create_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to authenticated_root_path, notice: t('.create.success') }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render 'pages/onboarding', alert: t('.create.error') }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      @profile.avatar.attach(params[:avatar]) if params[:avatar].present?
      if @profile.update(profile_params) and @profile.avatar.attached?
        current_user.profile.onboarded = true
        current_user.profile.save
        current_user.profile.fill_info!
        format.html { redirect_to authenticated_root_path, notice: t('.update.success') }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render 'pages/onboarding', alert: t('.update.error') }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: t('.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = @user.profile
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:role, :first_name, :last_name, :nick_name, :pesel, :gender, :skills,
                                    :contact_number, :avatar, :user_id)
  end
end
