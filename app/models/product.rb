class Product < ApplicationRecord

    after_initialize :set_defaults
    before_save :capitalize_title

    has_many :reviews, dependent: :destroy
    belongs_to :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    validates :title, presence: true, uniqueness: { case_sensitive: false }, exclusion: { in: %w(Apple Microsoft Sony),
    message: "%{value} is reserved." }
    validates :price, numericality: { greater_than: 0 }
    validates_numericality_of :sale_price, :less_than_or_equal_to => :price
    validates :description, presence: true, length: { minimum: 10 }
    # validates :image_url, uniqueness: true


    def self.search(word)
        return self.where("title LIKE ? OR description LIKE ?", "%#{word}%", "%#{word}%")
    end

  # another way  # scope :search, ->(query) { where("title ILIKE ? OR  description ILIKE ?", "%#{query}%", "%#{query}%") }

    private

        def set_defaults
            self.price ||=1.0
            self.sale_price ||=self.price
        end      

        def capitalize_title
            self.title.capitalize!
        end

end

# The title must be present
# The title must be unique (case insensitive)
# The price must be a number that is more than 0
# The description must be present
# The description must have at least 10 characters

# A callback method to set the default price to 1
# A callback method to capitalize the product title before saving