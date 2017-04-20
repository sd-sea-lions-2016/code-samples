# Recursive Solution
def binary_search(target, collection, min_index = 0, max_index = collection.size - 1)
  # Base Cases
  return nil if collection.empty? || max_index < min_index

  index_to_check = mid_point(min_index, max_index)

  # Base Case
  return index_to_check if collection[index_to_check] == target

  # Recursive Calls
  if collection[index_to_check] < target
    # Notice the change of one input, getting closer to at least one base case
    binary_search(target, collection, (index_to_check + 1), max_index)
  elsif collection[index_to_check] > target
    # Notice the change of one input, getting closer to at least one base case
    binary_search(target, collection, min_index, (index_to_check - 1))
  else
    # I don't ever expect this code to run, and I want my program to yell at me
    # if it ever does
    raise StandardError, "Something went unexpectedly wrong"
  end
end

def mid_point(min, max)
  (min + max) / 2
end

# Iterative Solution
def binary_search(target, collection, min_index = 0, max_index = collection.size - 1)
  # "Precondition" - same as the first base casee
  return nil if collection.empty?

  # Condition to exit iteration - same as the second base case
  until max_index < min_index
    index_to_check = mid_point(min_index, max_index)
    # Condition to exit method early - same as the third base case
    if collection[index_to_check] == target
      return index_to_check
    elsif collection[index_to_check] < target
      # We are modifying the same thing, just no recursive call
      min_index = index_to_check + 1
    elsif collection[index_to_check] > target
      # We are modifying the same thing, just no recursive call
      max_index = index_to_check - 1
    else
      # I don't ever expect this code to run, and I want my program to yell at me
      # if it ever does
      raise StandardError, "Something went unexpectedly wrong"
    end
  end
  nil # If our code gets here, we know that the element isn't in the collection
end

# Really shortened, unsafe version of iterative solution
def binary_search(target, collection, min_index = 0, max_index = collection.size - 1)
  return nil if collection.empty?
  loop do
    return nil if max_index < min_index
    index_to_check = mid_point(min_index, max_index)
    return index_to_check if collection[index_to_check] == target
    min_index = index_to_check + 1 if collection[index_to_check] < target
    max_index = index_to_check - 1 if collection[index_to_check] > target
  end
end
