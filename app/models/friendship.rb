class Friendship < ApplicationRecord
  validates :member_id, presence: true
  validates :friend_id, presence: true, uniqueness: { scope: :member_id }
  validate :not_self

  belongs_to :member, counter_cache: true
  belongs_to :friend, class_name: 'Member', counter_cache: true

  private

  def not_self
    errors.add(:friend_id, "can't be equal to member") if member == friend
  end
end
