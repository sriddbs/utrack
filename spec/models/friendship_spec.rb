require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    member = FactoryBot.create(:member)
    friend = FactoryBot.create(:member)
    subject { FactoryBot.create(:friendship, member: member, friend: friend) }

    it { should validate_presence_of(:member_id) }
    it { should validate_presence_of(:friend_id) }
    it { should validate_uniqueness_of(:friend_id).scoped_to(:member_id) }
  end

  describe 'associations' do
    it { should belong_to(:member) }
    it { should belong_to(:friend) }
  end
end
