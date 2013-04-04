class Article < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :show_dividerline, :topic, :newsletter_id
  # validates :newsletter, presence: true # raises error in nested forms
end
