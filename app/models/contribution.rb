# == Schema Information
#
# Table name: contributions
#
#  id                :bigint           not null, primary key
#  contribution_type :integer
#  end_date          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_contributions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Contribution < ApplicationRecord
  CONTRIBUTION_DURATION = {
    monthly: 1.month,
    half_year: 6.month,
    annual: 1.year
  }
  CONTRIBUTION_COST = {
    monthly: 50,
    half_year: 300,
    annual: 50,
  }

  enum contribution_type: {
    monthly: 0,
    half_year: 1,
    annual: 2,
    donation: 3,
    calculated_contribution: 4
  }
  
  belongs_to :user

  def active?
    end_date ? end_date.future? : false
  end

  def ends_soon?
    end_date && end_date.future? && end_date < 7.days.from_now
  end

  def bump_end_date(contribution_type)
    if end_date
      if end_date < Time.now
        reference_date = Time.now
      else
        reference_date = end_date
      end
    else
      reference_date = Time.now
    end
    self.update_attribute(:end_date, reference_date + CONTRIBUTION_DURATION[contribution_type.to_sym])
  end

  def self.amount(contribution_type)
    if contribution_type == 'monthly'
      CONTRIBUTION_COST[:monthly]
    elsif contribution_type == 'half_year'
      CONTRIBUTION_COST[:half_year]
    elsif contribution_type == 'annual'
      CONTRIBUTION_COST[:annual]
    end
  end
end
