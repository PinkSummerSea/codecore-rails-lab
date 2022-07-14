# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Product.destroy_all
Review.destroy_all
User.destroy_all

super_user = User.create({
  first_name: "Admin",
  last_name: "User",
  email: "admin@user.com",
  password: "8855705",
  is_admin: true
})

summer = User.create({
  first_name: "Summer",
  last_name: "Lin",
  email: "lin.summer@outlook.com",
  password: "8855705",
  is_admin: true
})

10.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}@#{last_name.downcase}.com",
        password: "123"
    )
end

users = User.all

i = 0

21.times do
    created_at = Faker::Date.backward(days:365)

    p = Product.create(
        title: Faker::Food.dish,
        description: Faker::Food.description,
        price: Faker::Commerce.price,
        image_file: "#{i}.jpg",
        created_at: created_at,
        updated_at: created_at,
        # user_id: users.sample.id # why not this?
        user: users.sample
    )

    i = i + 1

    if p.valid?
        rand(5..10).times do
            Review.create(
                rating: rand(1..5),
                body: Faker::Quote.most_interesting_man_in_the_world,
                product: p,
                user: users.sample
            )
        end
    end

end