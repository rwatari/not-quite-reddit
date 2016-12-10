module Voteable
  extend ActiveSupport::Concern

  included { has_many :votes, as: :voteable }

  def score
    self.votes.sum(:value)
  end
end
