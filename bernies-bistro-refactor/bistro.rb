require 'csv'

class Recipe
  attr_reader :name, :description, :ingredients, :directions, :author
  attr_accessor :id

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @description = args[:description] || "No Description"
    @ingredients = args[:ingredients]
    @directions = args[:directions]
    @author = args[:author] || "Uncredited"
  end

  def to_s
    "#{id} - #{name}\n
      #{description}\n
      Ingrediants:\n
      #{ingredients}\n
      Preparation Instructions:\n
      #{directions}\n
      Written by:  #{author}"
  end

  def list_form
    "#{id}. #{name}"
  end
end


class Bistro
  attr_accessor :recipes

  def initialize(recipes = [])
    @recipes = recipes
  end

  def find_recipe_by_id(recipe_id)
    recipes.each do |recipe|
      return recipe if recipe_id == recipe.id
    end

    raise "Can't find a recipe with an id of #{recipe_id.inspect}"
  end

  def recipe_list
    recipes.map { |recipe| recipe.list_form }
  end
end


class RecipeParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def csv_to_recipes
    CSV.readlines(filename, {headers: true, header_converters: :symbol}).map.with_index(1) do |recipe_data, index|
      Recipe.new recipe_data
    end
  end
end

module IDAssigner
  def self.reassign_ids(collection)
    collection.each.with_index(1) do |element, index|
      element.id = index.to_s
    end
  end
end




if ARGV.any?
  filename = ARGV[0]
  command  = ARGV[1]
  option   = ARGV[2]

  recipes = RecipeParser.new(filename).csv_to_recipes
  sorted_recipes = IDAssigner.reassign_ids recipes.sort_by(&:name)

  bistro = Bistro.new(sorted_recipes)

  case command
  when "list"    then puts bistro.recipe_list
  when "display" then puts bistro.find_recipe_by_id(option)
  end
end
