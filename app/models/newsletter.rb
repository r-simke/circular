class Newsletter < ActiveRecord::Base
  has_many :articles, order: "position", dependent: :destroy
  attr_accessible :author_id, :code, :content, :show_dividerline, :show_outline, :status_id, :template_id, :topic
end
