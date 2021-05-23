# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email should be john@example.com' do
    stub = build_stubbed(:user)

    expect(stub.email).to eq('john@example.com')
  end
end
