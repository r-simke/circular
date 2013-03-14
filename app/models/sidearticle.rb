class Sidearticle < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :topic, :newsletter_id
  acts_as_list scope: :newsletter
  validates :newsletter, presence: true
end
