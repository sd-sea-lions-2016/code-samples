# This code has been is the original solution for solving the
# the straight line word search.
# The code has been refactored in 'word_search.rb'
# The code there should be more readable and testable.

# NOTE: This only includes the straight line solution, not the snake solution.

def straight_line_include?(word, puzzle)
  (puzzle + puzzle.transpose + diagonal_arrays_from(puzzle)).any? do |array|
    array_include?(word, array)
  end
end

def array_include?(word, array)
  array.join.include?(word) || array.join.reverse.include?(word)
end

### The following is only needed for solving diagonals ###

def diagonal_arrays_from(nested_arrays)
  forward_diagonals_from(nested_arrays) + backward_diagonals_from(nested_arrays)
end

def forward_diagonals_from(nested_arrays)
  diagonals = []
  nested_arrays.each_with_index do |row, row_index|
    diagonals << ([nil] * (row.length-1 - row_index)) + row + ([nil] * row_index)
  end
  diagonals.transpose.each(&:compact!)
end

def backward_diagonals_from(nested_arrays)
  diagonals = []
  nested_arrays.each_with_index do |row, row_index|
    diagonals << ([nil] * row_index) + row + ([nil] * (row.length-1 - row_index))
  end
  diagonals.transpose.each(&:compact!)
end

# def snaking_include?(word, puzzle)
# end
