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
require 'rails_helper'

RSpec.describe Contribution, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  let(:user) { create(:user)}
  let(:contribution) { create(:contribution, end_date: end_date, user_id: user.id) }

  describe '#bump_end_date' do
    context 'when today is 2021-07-07' do
      before { travel_to (Date.parse('2021-07-07')) { contribution.bump_end_date(contribution_type); contribution.reload } }

      context 'annual' do
        let(:contribution_type) { 'annual' }

        context 'when no end date yet' do
          let(:end_date) { nil }

          it 'is 2022-07-07' do
            expect(contribution.end_date).to eq Date.parse('2022-07-07')
          end
        end

        context 'when end date is 2021-07-07' do
          let(:end_date) { Date.parse('2021-07-07') }

          it 'is 2022-07-07' do
            expect(contribution.end_date).to eq Date.parse('2022-07-07')
          end
        end
      end

      context 'half_year' do
        let(:contribution_type) { 'half_year' }

        context 'when no end date yet' do
          let(:end_date) { nil }

          it 'is 2021-07-07' do
            expect(contribution.end_date).to eq Date.parse('2022-01-07')
          end
        end

        context 'when end date is 2021-07-07' do
          let(:end_date) { Date.parse('2021-07-07') }

          it 'is 2022-01-07' do
            expect(contribution.end_date).to eq Date.parse('2022-01-07')
          end
        end

        context 'when end date is 2021-08-07' do
          let(:end_date) { Date.parse('2021-08-07') }

          it 'is 2022-02-07' do
            expect(contribution.end_date).to eq Date.parse('2022-02-07')
          end
        end

        context 'when end date is 2021-02-07' do
          let(:end_date) { Date.parse('2021-02-07') }

          it 'is 2022-01-07' do
            expect(contribution.end_date).to eq Date.parse('2022-01-07')
          end
        end

        context 'when end date is 2022-01-07' do
          let(:end_date) { Date.parse('2022-01-07') }

          it 'is 2022-07-07' do
            expect(contribution.end_date).to eq Date.parse('2022-07-07')
          end
        end
      end

      context 'monthly' do
        let(:contribution_type) { 'monthly' }

        context 'when no end date yet' do
          let(:end_date) { nil }

          it 'is 2021-08-07' do
            expect(contribution.end_date).to eq Date.parse('2021-08-07')
          end
        end

        context 'when end date is 2021-07-07' do
          let(:end_date) { Date.parse('2021-07-07') }

          it 'is 2021-08-07' do
            expect(contribution.end_date).to eq Date.parse('2021-08-07')
          end
        end

        context 'when end date is 2021-08-07' do
          let(:end_date) { Date.parse('2021-08-07') }

          it 'is 2021-09-07' do
            expect(contribution.end_date).to eq Date.parse('2021-09-07')
          end
        end

        context 'when end date is 2020-12-07' do
          let(:end_date) { Date.parse('2020-12-07') }

          it 'is 2021-08-07' do
            expect(contribution.end_date).to eq Date.parse('2021-08-07')
          end
        end

        context 'when end date is 2021-12-07' do
          let(:end_date) { Date.parse('2021-12-07') }

          it 'is 2022-01-07' do
            expect(contribution.end_date).to eq Date.parse('2022-01-07')
          end
        end
      end
    end
  end
end
