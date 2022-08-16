class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :created_at, :updated_at, :sale_price, :image_file

  belongs_to :user, key: :seller
  has_many :reviews

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :full_name
  end

  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating#, :user

    # belongs_to :user

    # class UserSerializer < ActiveModel::Serializer
    #   attributes :id, :first_name, :last_name, :email, :full_name
    # end
  end
end
