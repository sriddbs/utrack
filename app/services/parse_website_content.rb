require 'open-uri'

class ParseWebsiteContent
  def initialize(member)
    @member = member
  end

  def call
    parse
  end

  private

  def parse
    contents = { headings: [] }

    doc = Nokogiri::HTML(open(@member.website_url))

      doc.css(Member::WEBSITE_HTML_ELEMENTS).each do |link|
      contents[:headings] << link.content.strip
    end

    @member.website_contents = contents
    @member.save!
  end
end
