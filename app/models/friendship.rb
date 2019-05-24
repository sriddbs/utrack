class Friendship < ApplicationRecord
  validates :member_id, presence: true
  validates :friend_id, presence: true, uniqueness: { scope: :member_id }

  belongs_to :member, counter_cache: true
  belongs_to :friend, class_name: 'Member', counter_cache: true
end
