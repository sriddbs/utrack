require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:website_url) }
    it { should allow_value('http://foo.com').for(:website_url) }
  end

  describe 'associations' do
    it { should have_many(:friends) }
    it { should have_many(:inverse_friends) }
  end

  describe '.search' do
    before(:each) do
      FactoryBot.create_list(:member, 3, :with_website_contents)
    end

    context 'matching heading found' do
      it 'returns members and the relevant matched headings' do

        members = Member.search('heading 1')

        expect(members).not_to be_empty
        expect(members.size).to eql(1)
        expect(members.map(&:value)).to eql(['Heading 1'])
      end
    end

    context 'no matching heading found' do
      it 'returns empty' do
        members = Member.search('something')

        expect(members).to be_empty
        expect(members.size).to eql(0)
      end
    end
  end

  describe '#generate_url_key' do
    it 'generates unique_id of specified length' do
      member = FactoryBot.create(:member)

      expect(member).to be_valid
      expect(member.url_key).not_to be_nil
      expect(member.url_key.size).to eql(Member::UNIQUE_ID_LENGTH)
    end
  end
end
