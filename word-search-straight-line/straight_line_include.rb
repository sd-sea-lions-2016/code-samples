def straight_line_include?(word, puzzle)
  straight_lines(puzzle).any? { |row| row.match(word) }
end

def straight_lines(puzzle)
  combined_rows(puzzle) +
  combined_rows_reversed(puzzle) +
  combined_columns(puzzle) +
  combined_columns_reversed(puzzle) +
  combined_uphill_diagonals_reversed(puzzle) +
  combined_uphill_diagonals(puzzle) +
  combined_downhill_diagonals(puzzle) +
  combined_downhill_diagonals_reversed(puzzle)
end

def combined_rows(puzzle)
  puzzle.map(&:join)
end

def combined_rows_reversed(puzzle)
  combined_rows(puzzle).map(&:reverse)
end

def combined_columns(puzzle)
  combined_rows(puzzle.transpose)
end

def combined_columns_reversed(puzzle)
  combined_columns(puzzle).map(&:reverse)
end

def combined_uphill_diagonals_reversed(puzzle)
  combined_rows(top_right_to_bottom_left_diagonals(puzzle))
end

def combined_uphill_diagonals(puzzle)
  combined_uphill_diagonals_reversed(puzzle).map(&:reverse)
end

def combined_downhill_diagonals(puzzle)
  combined_uphill_diagonals_reversed(puzzle.map(&:reverse)).reverse
end

def combined_downhill_diagonals_reversed(puzzle)
  combined_downhill_diagonals(puzzle).map(&:reverse)
end

def top_right_to_bottom_left_diagonals(puzzle)
  top_right_to_bottom_left_diagonals_in_columns(puzzle).transpose.map(&:compact)
end

def top_right_to_bottom_left_diagonals_in_columns(puzzle)
  row_length_to_align_diagonals = puzzle.length * 2 - 1

  puzzle.map.with_index do |row, row_index|
    row_with_padded_back = pad_back(row, row_length_to_align_diagonals - row_index)
    pad_front(row_with_padded_back, row_length_to_align_diagonals)
  end
end

def pad_back(collection, target_size)
  collection + Array.new(size_diff(collection, target_size), nil)
end

def pad_front(collection, target_size)
  Array.new(size_diff(collection, target_size), nil) + collection
end

def size_diff(collection, target_size)
  target_size - collection.size
end
