class Post < ActiveRecord::Base
  attr_accessible :content, :image, :title, :ref
  
  validates :content, presence: true
  validates :title, presence: true
  validates :image, presence: true
  
  default_scope order: 'posts.created_at DESC'
end
