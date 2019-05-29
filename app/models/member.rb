class Member < ApplicationRecord
  UNIQUE_ID_LENGTH = 6.freeze
  BASE_SHORT_URL = 'http://tiny.ut'.freeze
  WEBSITE_HTML_ELEMENTS = 'h1, h2, h3'.freeze

  validates :name, presence: true
  validates :url_key, presence: true
  validates :website_url, presence: true
  validates_format_of :website_url, with: URI::regexp(%w(http https))

  before_validation :generate_url_key, on: :create

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, :through => :inverse_friendships, :source => :member

  scope :filter_by_heading, ->(keyword, member_id=nil) {
    if member_id
      Member.find_by_sql("select * from members, jsonb_array_elements_text(website_contents->'headings') as data
        where data ILIKE '%#{keyword}%' AND id != #{member_id} ORDER BY created_at DESC")
    else
      Member.find_by_sql("select * from members, jsonb_array_elements_text(website_contents->'headings') as data
        where data ILIKE '%#{keyword}%' ORDER BY created_at DESC")
    end
  }

  class << self
    def search(keyword, member_id=nil)
      filter_by_heading(keyword, member_id)
    end
  end

  private

  def generate_url_key
    unique_id = ([*('a'..'z'), *('A'..'Z'), *('0'..'9')]).sample(UNIQUE_ID_LENGTH).join

    if Member.where(url_key: unique_id).exists?
      generate_url_key
    end

    self.url_key = unique_id
  end
end
