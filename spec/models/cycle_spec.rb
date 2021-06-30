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
require 'rails_helper'

RSpec.describe Cycle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
