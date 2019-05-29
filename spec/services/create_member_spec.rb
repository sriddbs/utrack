require 'rails_helper'

RSpec.describe CreateMember do
  let(:params) { { name: 'abc', website_url: 'http://google.com' }}
  subject { CreateMember.new(params) }

  context 'valid parameters' do
    it 'creates a new member' do
      result = subject.call
      member = result.object

      expect(member).to be_persisted
      expect(member.name).to eql('abc')
      expect(member.website_url).to eql('http://google.com')
    end
  end

  context 'invalid parameters' do
    let(:params) { { name: 'abc' } }

    it 'returns error message' do
      result = subject.call
      member = result.object

      expect(result.message).to eql("Website url can't be blank, Website url is invalid")
      expect(result.success).to be_falsy
      expect(member).not_to be_persisted
    end
  end
end
