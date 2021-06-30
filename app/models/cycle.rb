# == Schema Information
#
# Table name: cycles
#
#  id                      :bigint           not null, primary key
#  aasm_state              :string
#  annual_paid_on          :datetime
#  current_study_renews_on :datetime
#  monthly_cycle_start_day :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_cycles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cycle < ApplicationRecord
  belongs_to :user
  include AASM

  aasm do
    state :active, initial: true
    state :payment_pending, :survey_pending, :booking_pending

    event :activate do
      transitions to: :active, guard: :cycle_clear?
    end

    event :payment_lock do
      transitions from: :active, to: :payment_pending
    end

    event :survey_lock do
      transitions from: :active, to: :survey_pending
    end

    event :booking_lock do
      transitions from: :active, to: :booking_pending
    end
  end

  private

  def cycle_clear?
    true
  end
end
