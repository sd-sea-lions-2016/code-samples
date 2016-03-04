# This code has been refactored from 'word_search_minimal.rb'
# It is more readable and testable with the methods split out.

# NOTE: This only includes the straight line solution, not the snake solution.

def straight_line_include?(word, puzzle)
  possible_arrays_for(puzzle).any? {|array| array_include?(word, array) }
end

def array_include?(word, array)
  array.join.include?(word) || array.join.reverse.include?(word)
end

def possible_arrays_for(puzzle)
  # To solve just for rows and columns, take off the `diagonals_for(puzzle)`
  rows_for(puzzle) + columns_for(puzzle) + diagonals_for(puzzle)
end

def rows_for(puzzle)
  puzzle
end

def columns_for(puzzle)
  puzzle.transpose
end

### The following is only needed for solving diagonals ###

def diagonals_for(puzzle)
  forward_diagonals_from(puzzle) + backward_diagonals_from(puzzle)
end

# forward_diagonals_from and backward_diagonals_from look very similar, and they
# could probably be refactored to be one method with additional arguments / options
def forward_diagonals_from(puzzle)
  diagonals = []
  puzzle.each_with_index do |row, row_index|
    diagonals << (row_buffer_high(row.length, row_index)) + row + (row_buffer_low(row_index))
  end
  diagonals.transpose.each(&:compact!)
end

def backward_diagonals_from(puzzle)
  diagonals = []
  puzzle.each_with_index do |row, row_index|
    diagonals << (row_buffer_low(row_index)) + row + (row_buffer_high(row.length, row_index))
  end
  diagonals.transpose.each(&:compact!)
end

def row_buffer_high(row_length, row_index)
  nils_to_buffer(row_length-1 - row_index)
end

def row_buffer_low(row_index)
  nils_to_buffer(row_index)
end

def nils_to_buffer(number)
  [nil] * number
end

# def snaking_include?(word, puzzle)
# end
