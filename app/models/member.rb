class Member < ApplicationRecord
  UNIQUE_ID_LENGTH = 6.freeze
  BASE_SHORT_URL = 'http://tiny.ut'.freeze

  validates :name, presence: true
  validates :url_key, presence: true
  validates :website_url, presence: true

  before_validation :generate_url_key, on: :create
  before_save :sanitize_url

  private

  def generate_url_key
    unique_id = ([*('a'..'z'), *('A'..'Z'), *('0'..'9')]).sample(UNIQUE_ID_LENGTH).join

    if Member.where(url_key: unique_id).exists?
      generate_url_key
    end

    self.url_key = unique_id
  end

  def sanitize_url
    self.website_url.strip!
    sanitized_url = self.website_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    self.website_url = "http://#{sanitized_url}"
  end
end
