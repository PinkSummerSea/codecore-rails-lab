require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validates" do
    describe "first_name" do
      it "requires first_name to be present" do
        user = FactoryBot.build(:user, first_name: nil)

        user.valid?

        expect(user.errors.messages).to(have_key(:first_name))
      end
    end

    describe "last_name" do
      it "requires last_name to be present" do
        user = FactoryBot.build(:user, last_name: nil)

        user.valid?

        expect(user.errors.messages).to(have_key(:last_name))
      end
    end

    describe "email" do
      it "requires a unique email" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.build(:user, email: user1.email)
        user2.valid?
        expect(user2.errors.messages).to(have_key(:email))
      end
    end
  end
end
