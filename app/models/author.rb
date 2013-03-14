class Author < ActiveRecord::Base
  attr_accessible :email, :image_url, :name, :phone, :title
  has_many :newsletters
end
