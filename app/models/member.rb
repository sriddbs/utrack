class Member < ApplicationRecord
  UNIQUE_ID_LENGTH = 6.freeze
  BASE_SHORT_URL = 'http://tiny.ut'.freeze
  WEBSITE_HTML_ELEMENTS = 'h1, h2, h3'.freeze

  validates :name, presence: true
  validates :url_key, presence: true
  validates :website_url, presence: true

  before_validation :generate_url_key, on: :create
  before_save :sanitize_url

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, :through => :inverse_friendships, :source => :member

  scope :filter_by_heading, ->(keyword) { where("website_contents->>'headings' ILIKE ?", "%#{keyword}%") }

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
