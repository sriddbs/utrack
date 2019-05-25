require 'open-uri'

class ParseWebsiteContent
  def initialize(member)
    @member = member
  end

  def call
    parse
  end

  private

  def website_contents
    Nokogiri::HTML(open(@member.website_url))
  end

  def parse
    contents = { headings: [] }

    website_contents.css(Member::WEBSITE_HTML_ELEMENTS).each do |link|
      contents[:headings] << link.content.strip
    end

    @member.website_contents = contents
    @member.save!
  end
end
