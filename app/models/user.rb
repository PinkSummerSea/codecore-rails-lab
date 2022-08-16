class User < ApplicationRecord

    has_secure_password
    # Adds attribute accessors to the user model for password and password_confirmation
    # Validates presence of password and password matching with password_confirmation if present
    # Encrypts the password and stores it in password_digest using the bcrypt gem
    
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :nullify
    has_many :likes, dependent: :nullify
    has_many :liked_reviews, through: :likes, source: :review

    before_validation :downcase_email

    validates :first_name, presence: true
    validates :last_name, presence: true

    validates :email, presence: true, uniqueness: { case_sensitive: false }

    validates :password_digest, presence: true

    def full_name
        self.first_name + " " + self.last_name
    end

    def self.search(search_term)
        return self.where(first_name: search_term).or(self.where(last_name: search_term)).or(self.where(email: search_term))
    end

    def downcase_email
        self.email = self.email.downcase
    end

end


# another way # scope(:search, ->(search_term) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%") })