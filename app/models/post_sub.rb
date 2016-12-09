# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub

  validates :post, :sub, presence: true
  validates :sub_id, uniqueness: { scope: :post_id }
end
