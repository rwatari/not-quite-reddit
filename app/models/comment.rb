# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :author, foreign_key: :user_id, class_name: :User
  belongs_to :post
  belongs_to :parent_comment, class_name: :Comment

  has_many :children,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    dependent: :nullify

  validates :content, :user_id, :post_id, presence: true
  validates :content, length: {
    minimum: 25,
    message: "Don't spam. Big brother see you!"
  }

end
