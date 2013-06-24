class Post < ActiveRecord::Base
  attr_accessible :content, :image
  
  validates :content, presence: true
  
  default_scope order: 'posts.created_at DESC'
end
