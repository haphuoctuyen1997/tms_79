require "rails_helper"

RSpec.describe User, type: :model do
  let(:user1) {FactoryBot.create :user }
  let(:user2) {FactoryBot.create :user }
  let(:admin) {FactoryBot.create :admin }

  describe "db schema" do
    context "columns" do
      it do
        should have_db_column(:email).of_type(:string)
        should have_db_column(:name).of_type(:string)
        should have_db_column(:password_digest).of_type(:string)
        should have_db_column(:address).of_type(:string)
        should have_db_column(:phone_number).of_type(:string)
        should have_db_column(:avatar).of_type(:string)
        should have_db_column(:role).of_type(:integer)
        should define_enum_for(:role).with([:suppervisor, :trainee])
      end
    end
  end


  describe "validate" do
    it do
      should validate_presence_of(:email).with_message("can't be blank")
      should validate_uniqueness_of(:email).case_insensitive
      should validate_presence_of(:name).with_message("can't be blank")
      should validate_length_of(:name).is_at_most(50)
        .with_message("is too long (maximum is 50 characters)")
      should validate_length_of(:password).is_at_least(6)
        .with_message("is too short (minimum is 6 characters)")
      should allow_value("").for(:password_confirmation)
        .with_message("can't be blank")
      should validate_length_of(:password_confirmation)
        .is_at_least(6).with_message("is too short (minimum is 6 characters)")
      should validate_presence_of(:address)
        .with_message("can't be blank")
      should validate_length_of(:address).is_at_most(200)
        .with_message("is too long (maximum is 200 characters)")
      should validate_presence_of(:phone_number)
        .with_message("can't be blank")
      should validate_length_of(:phone_number).is_at_least(10)
        .with_message("is too short (minimum is 10 characters)")
    end
  end

  describe "relationships" do
    it do
    should have_many(:user_courses).dependent(:destroy)
    should have_many(:user_tasks).dependent(:destroy)
    should have_many(:courses).through(:user_courses).dependent(:destroy)
    end
  end

  describe "scope" do
    it "return a sorted array of result that match" do
      expect(User.newest).to eq([user2, user1])
    end
  end

  describe "#password" do
    it {is_expected.to_not allow_value(Faker::Internet.password(5,5)).for(:password)}
    it {is_expected.to allow_value(Faker::Internet.password(6,6)).for(:password)}
  end
  describe "#email" do
    it {is_expected.to_not allow_value("abc").for(:email)}
    it {is_expected.to allow_value("a@b.com").for(:email)}
  end
end
