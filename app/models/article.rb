class Article < ApplicationRecord
    # include Visible
    has_many :comments, dependent: :destroy 
    has_many :taggables, dependent: :destroy
    #has many tags, throuhg taggables (through that table THE JOIN TABLE)
    has_many :tags, through: :taggables
    has_rich_text :description
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
    #avatar uploader will handel everything
    mount_uploader :image, AvatarUploader
    
      

end
