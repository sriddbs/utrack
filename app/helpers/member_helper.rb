module MemberHelper
  def website_short_url(key)
    "#{Member::BASE_SHORT_URL}/#{key}"
  end
end
