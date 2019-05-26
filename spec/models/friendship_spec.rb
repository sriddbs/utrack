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

  describe 'friendship' do
    context 'when the other member is not already a friend' do
      it 'creates a mutual friendship' do
        member = FactoryBot.create(:member)
        friend = FactoryBot.create(:member)

        expect { FactoryBot.create(:friendship, member: member, friend: friend) }.to change { Friendship.count }.by(1)
        expect(member.friendships_count).to eql(1)
        expect(friend.friendships_count).to eql(1)
      end
    end

    context 'when the other member is already a friend' do
      it 'does not create friendship again' do
        friend = FactoryBot.create(:member)
        member = FactoryBot.create(:member, :with_friends, friend: friend)

        friendship = FactoryBot.build(:friendship, member: member, friend: friend)
        friendship.valid?

        expect(friendship).not_to be_valid
        expect(friendship.errors.messages).to eql({:friend_id=>["has already been taken"]})
        expect(member.friendships_count).to eql(1)
        expect(friend.friendships_count).to eql(1)
      end
    end

    context 'when member and friend are same' do
      it 'does not create friendship and throws error' do
        member = FactoryBot.create(:member)

        friendship = FactoryBot.build(:friendship, member: member, friend: member)
        friendship.valid?

        expect(friendship).not_to be_valid
        expect(friendship.errors.messages).to eql({:friend_id=>["can't be equal to member"]})
      end
    end
  end
end
