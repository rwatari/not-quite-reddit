class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, inclusion: { in: [1, -1] }, presence: true
  validates :voteable_id, :voteable_type, presence: true
  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type] }
end
