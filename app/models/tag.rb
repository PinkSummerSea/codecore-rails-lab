class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :products, through: :taggings

    # validation
    validates :name, presence: true, uniqueness: {
        case_sensitive: false
    }
end
