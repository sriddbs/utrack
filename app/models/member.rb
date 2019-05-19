class Member < ApplicationRecord
  validates :name, presence: true
  validates :website_short_url, presence: true
  validates :website_url, presence: true
end
