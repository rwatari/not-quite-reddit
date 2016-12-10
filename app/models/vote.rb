class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true

  validates :value, inclusion: { in: [1, -1] }, presence: true
  validates :voteable_id, :voteable_type, presence: true
end
