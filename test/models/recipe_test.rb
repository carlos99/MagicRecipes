require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.create(chef_name: "Carlos", email: "carlos.chef@gmail.com")
		@recipe = @chef.recipes.build(name: "Chicken Parm", summary: "This is the best Chicken Parm Ever", description: "heat oil, tomate sauce, cook for 20 minutes")
	end

	test "recipe should be valid" do
		assert @recipe.valid?
	end

	test "Chef Id should be present" do
		@recipe.chef_id = nil
		assert_not @recipe.valid?
	end	

	test "name should be present" do
		@recipe.name = ""
		assert_not @recipe.valid?
	end

	test "name length should not be to long" do
		@recipe.name = "a" * 101
		assert_not @recipe.valid?
	end

	test "name length should not be to short" do
		@recipe.name = "aaaa"
		assert_not @recipe.valid?
	end

	test "Summary should be present" do
		@recipe.summary = ""
		assert_not @recipe.valid?
	end

	test "Summary length should not be to long" do
		@recipe.summary = "a" * 151
		assert_not @recipe.valid?
	end

	test "Summary length should not be to short" do
		@recipe.summary = "a" * 9
		assert_not @recipe.valid?
	end

	test "Description should be present" do
		@recipe.description = ""
		assert_not @recipe.valid?
	end

	test "Description length should not be to long" do
		@recipe.description = "a" * 501
		assert_not @recipe.valid?
	end

	test "Description length should not be to short" do
		@recipe.description = "a" * 19
		assert_not @recipe.valid?
	end
end