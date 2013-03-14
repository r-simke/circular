class Article < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :show_dividerline, :topic, :newsletter_id
  acts_as_list scope: :newsletter
  validates :newsletter, presence: true
end
