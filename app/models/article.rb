class Article < ApplicationRecord
    # include Visible
    has_many :comments, dependent: :destroy
    has_rich_text :description
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
    #avatar uploader will handel everything
    mount_uploader :image, AvatarUploader
    
      

end
