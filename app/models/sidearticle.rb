class Sidearticle < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :content, :position, :topic
end
