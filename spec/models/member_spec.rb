require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:website_url) }
  end

  describe '#generate_url_key' do
    it 'generates unique_id of specified length' do
      member = FactoryBot.create(:member)

      expect(member).to be_valid
      expect(member.url_key).not_to be_nil
      expect(member.url_key.size).to eql(Member::UNIQUE_ID_LENGTH)
    end
  end

  describe '#sanitize_url' do
    it 'ensures that urls that point to the same web page are seen as the same url' do
      member_1 = FactoryBot.create(:member, website_url: 'https://github.com')
      member_2 = FactoryBot.create(:member, website_url: 'google.com')

      expect(member_1).to be_valid
      expect(member_1.website_url).to start_with('http')
      expect(member_2).to be_valid
      expect(member_2.website_url).to start_with('http')
    end
  end
end
