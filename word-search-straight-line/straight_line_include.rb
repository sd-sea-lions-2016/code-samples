def straight_line_include?(word, puzzle)
  straight_lines(puzzle).any? { |row| row.match(word) }
end

def straight_lines(puzzle)
  combined_rows(puzzle) +
  combined_rows_backward(puzzle) +
  combined_columns(puzzle) +
  combined_columns_backward(puzzle) +
  combined_diagonals_top_right_to_bottom_left(puzzle) +
  combined_diagonals_bottom_left_to_top_right(puzzle) +
  combined_diagonals_top_left_to_bottom_right(puzzle) +
  combined_diagonals_bottom_right_to_top_left(puzzle)
end

def combined_rows(puzzle)
  puzzle.map(&:join)
end

def combined_rows_backward(puzzle)
  combined_rows(puzzle).map(&:reverse)
end

def combined_columns(puzzle)
  combined_rows(puzzle.transpose)
end

def combined_columns_backward(puzzle)
  combined_columns(puzzle).map(&:reverse)
end

def combined_diagonals_top_right_to_bottom_left(puzzle)
  combined_rows(top_right_to_bottom_left_diagonals(puzzle))
end

def combined_diagonals_bottom_left_to_top_right(puzzle)
  combined_diagonals_top_right_to_bottom_left(puzzle).map(&:reverse)
end

def combined_diagonals_top_left_to_bottom_right(puzzle)
  combined_diagonals_top_right_to_bottom_left(puzzle.map(&:reverse)).reverse
end

def combined_diagonals_bottom_right_to_top_left(puzzle)
  combined_diagonals_top_left_to_bottom_right(puzzle).map(&:reverse)
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
  size_difference = target_size - collection.size
  collection + Array.new(size_difference, nil)
end

def pad_front(collection, target_size)
  size_difference = target_size - collection.size
  Array.new(size_difference, nil) + collection
end
