# == Schema Information
#
# Table name: study_participations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  study_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_study_participations_on_study_id  (study_id)
#  index_study_participations_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (study_id => studies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StudyParticipation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
