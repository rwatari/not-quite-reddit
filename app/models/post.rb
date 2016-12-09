# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :author, foreign_key: :user_id, class_name: :User
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments

  validates :title, :user_id, presence: true

  def comments_by_parent_id
    all_comments = comments.includes(:author)

    comments_hash = Hash.new { |h, k| h[k] = [] }

    all_comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end

    comments_hash
  end
end
