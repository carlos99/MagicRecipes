require "test_helper"

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chef_name: "Carlos", email: "carlos@example.com")
	end

	test "Chef should be valid" do
		assert @chef.valid?
	end

	test "Chef name should be present" do
		@chef.chef_name = ""
		assert_not @chef.valid?
	end

	test "Chef name length should not be to long" do
		@chef.chef_name = "a" * 41
		assert_not @chef.valid?
	end

	test "Chef name length should not be to short" do
		@chef.chef_name = "aa"
		assert_not @chef.valid?
	end

	test "Email should be present" do
		@chef.email = ""
		assert_not @chef.valid?
	end

	test "Email length should be within bounds" do
		@chef.email = "a" * 96 + "@example.com"
		assert_not @chef.valid?
	end

	test "Email address should be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end

	test "Email validation should accept valid addresses" do
		valid_addresses = %w[user@eee.com R_TDD-DS@ee.hello.org user@example.com first.last@ee.au laura+joe@monk.cm]
		valid_addresses.each do |va|
			@chef.email = va
			assert @chef.valid?, '#{va.inspect} should be valid'
		end
	end

	test "Email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_aim_.com foo@ee+aar.com]
		invalid_addresses.each do |ia|
			@chef.email = ia
		assert_not @chef.valid?, '#{ia.inspect} should be invalid'
		end
	end

end