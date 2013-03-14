class Article < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :show_dividerline, :topic, :newsletter
  acts_as_list scope: :newsletter
  validates :topic, presence: true
  validates :newsletter, presence: true
end
