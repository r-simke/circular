class Article < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :antecessor, class_name:'Article'
  attr_accessible :content, :show_dividerline, :topic, :newsletter, :antecessor
  acts_as_list scope: :newsletter
end
