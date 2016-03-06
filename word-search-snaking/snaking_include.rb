USED_SPACE_MARKER = "-"

def snaking_include?(word, puzzle, base_coordinates = nil)
  return true if word.empty? && base_coordinates

  coordinates_matching_letter(first_letter(word), coordinates_to_search(base_coordinates, puzzle), puzzle).each do |coordinates|
    updated_puzzle = mark_used(coordinates, puzzle_copy(puzzle))
    return true if snaking_include?(trim(word), updated_puzzle, coordinates)
  end

  false
end

def coordinates_matching_letter(letter, coordinates_to_match, puzzle)
  coordinates_to_match.select { |coordinates| letter_at_coordinates?(letter, coordinates, puzzle)  }
end

def letter_at_coordinates?(letter, coordinates, puzzle)
  letter == letter_at(coordinates, puzzle)
end

def letter_at(coordinates, puzzle)
  puzzle.at(coordinates[:row]).at(coordinates[:column])
end

def coordinates_to_search(base_coordinates = nil, puzzle)
  base_coordinates ? neighboring_coordinates(base_coordinates, puzzle) : all_coordinates(puzzle)
end

def neighboring_coordinates(base_coordinates, puzzle)
  neighbor_rows(base_coordinates, puzzle).each_with_object(Array.new) do |row_index, neighboring_coordinates|
    neighbor_columns(base_coordinates, puzzle).each do |column_index|
      next if row_index == base_coordinates[:row] && column_index == base_coordinates[:column]
      neighboring_coordinates << { row: row_index, column: column_index }
    end
  end
end

def neighbor_rows(coordinates, puzzle)
  (coordinates[:row] - 1 .. coordinates[:row] + 1).to_a & valid_row_indexes(puzzle)
end

def neighbor_columns(coordinates, puzzle)
  (coordinates[:column] - 1 .. coordinates[:column] + 1).to_a & valid_column_indexes(puzzle)
end

def valid_row_indexes(puzzle)
  (0..puzzle.length - 1).to_a
end

def valid_column_indexes(puzzle)
  (0..puzzle.first.length - 1).to_a
end

def all_coordinates(puzzle)
  valid_row_indexes(puzzle).each_with_object(Array.new) do |row_index, coordinates|
    valid_column_indexes(puzzle).each do |column_index|
      coordinates << { row: row_index, column: column_index }
    end
  end
end

def mark_used(coordinates, puzzle)
  puzzle[coordinates[:row]][coordinates[:column]] = USED_SPACE_MARKER
  puzzle
end

def puzzle_copy(puzzle)
  puzzle.flatten.join.chars.each_slice(puzzle.first.length).to_a
end

def first_letter(word)
  word[0]
end

def trim(word)
  word[1..-1]
end
