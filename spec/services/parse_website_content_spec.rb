require 'rails_helper'

RSpec.describe ParseWebsiteContent do
  describe 'parse member website' do
    it 'retrives headings from website and store' do
      member = FactoryBot.create(:member)

      doc = Nokogiri::HTML(open("#{Rails.root}/spec/fixtures/my_website.html"))
      expect_any_instance_of(ParseWebsiteContent).to receive(:website_contents).and_return(doc)

      ParseWebsiteContent.new(member).call

      expect(member.website_contents).to eql(
        "headings" => ["Heading 1", "Heading 2", "Heading 3", "Heading 4", "Heading 5"]
      )
    end
  end
end
