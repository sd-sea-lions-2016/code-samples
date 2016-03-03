def binary_search(target, collection, min_index = 0, max_index = collection.size - 1)
  return nil if collection.empty? || max_index < min_index

  index_to_check = mid_point(min_index, max_index)

  return case
         when collection[index_to_check] == target
           index_to_check
         when collection[index_to_check] < target
           binary_search(target, collection, (min_index + 1), max_index)
         when collection[index_to_check] > target
           binary_search(target, collection, min_index, (index_to_check - 1))
         end
end

def mid_point(min, max)
  (min + max) / 2
end
