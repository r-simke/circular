class Newsletter < ActiveRecord::Base
  has_many :articles, order: "position", dependent: :destroy
  has_many :sidearticles, order: "position", dependent: :destroy
  attr_accessible :author_id, :code, :content, :show_dividerline, :show_outline, :status_id, :template_id, :topic, :articles_attributes, :sidearticles_attributes
  belongs_to :template
  belongs_to :author
  accepts_nested_attributes_for :articles, allow_destroy: true
  accepts_nested_attributes_for :sidearticles
end
