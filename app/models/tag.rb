class Tag < ApplicationRecord
    has_many :taggables, dependent: :destroy
    has_many :articles, through: :tagables
end
