class NewsArticle < ApplicationRecord
    before_save :titleize_title
    belongs_to :user

    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validate :published_after_created
     
    # scope :published, where( :published_at && :published_at > :created_at)

    def self.published
        where("published_at > created_at")
    end
    
    def publish 
        self.published_at = Time.current
    end

    private

    def titleize_title
        self.title = self.title.titleize
    end

    

    def published_after_created
        if self.published_at && self.published_at < self.created_at
            self.errors.add(:published_at, "Must be after the created_at time")
            p "published time error"
        end
    end
end
