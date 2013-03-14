class Sidearticle < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :topic, :newsletter
  acts_as_list scope: :newsletter
  validates :topic, presence: true
  validates :newsletter, presence: true
end
