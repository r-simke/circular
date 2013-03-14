class Template < ActiveRecord::Base
  attr_accessible :html, :name
  has_many :newsletters
  validates :name, presence: true
end
