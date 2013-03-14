class Newsletter < ActiveRecord::Base
  attr_accessible :author_id, :code, :content, :show_dividerline, :show_outline, :status_id, :template_id, :topic
end
