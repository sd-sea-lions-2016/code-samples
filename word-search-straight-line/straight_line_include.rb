def straight_line_include?(word, puzzle)
  straight_lines(puzzle).any?{|row| row.match(word) || row.match(word.reverse) }
end

def straight_lines(puzzle)
  joined_rows(puzzle) +
  joined_columns(puzzle) +
  joined_uphill_diagonals(puzzle) +
  joined_downhill_diagonals(puzzle)
end

def joined_rows(puzzle)
  puzzle.map(&:join)
end

def joined_rows_reversed(puzzle)
  joined_rows(puzzle).map(&:reverse)
end

def joined_columns(puzzle)
  joined_rows(puzzle.transpose)
end

def joined_uphill_diagonals(puzzle)
  joined_rows(top_left_to_bottom_right_diagonals(puzzle.map(&:reverse))).map(&:reverse).reverse
end

def joined_downhill_diagonals(puzzle)
  joined_rows(top_left_to_bottom_right_diagonals(puzzle))
end

def top_right_to_bottom_left_diagonals(puzzle)
  top_right_to_bottom_left_diagonals_in_columns(puzzle).transpose.map(&:compact)
end

def top_left_to_bottom_right_diagonals(puzzle)
  top_left_to_bottom_right_diagonals_in_columns(puzzle).transpose.map(&:compact)
end

def top_right_to_bottom_left_diagonals_in_columns(puzzle)
  row_length_to_align_diagonals = puzzle.length * 2 - 1

  puzzle.map.with_index do |row, row_index|
    row_with_padded_back = pad_back(row, row_length_to_align_diagonals - row_index)
    pad_front(row_with_padded_back, row_length_to_align_diagonals)
  end
end

def top_left_to_bottom_right_diagonals_in_columns(puzzle)
  top_right_to_bottom_left_diagonals_in_columns(puzzle.map(&:reverse)).map(&:reverse)
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
