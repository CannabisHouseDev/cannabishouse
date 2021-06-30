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
