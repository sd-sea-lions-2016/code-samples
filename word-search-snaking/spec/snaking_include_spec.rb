require_relative '../snaking_include'

describe 'snaking_include?' do
  let(:puzzle) do
    [ ["-", "-", "-", "-", "-", "-", "-"],
      ["-", "-", "-", "w", "a", "h", "-"],
      ["-", "-", "-", "k", "-", "t", "-"],
      ["-", "-", "s", "-", "h", "-", "-"],
      ["-", "-", "-", "g", "-", "-", "-"],
      ["-", "-", "-", "i", "-", "-", "-"],
      ["-", "-", "-", "n", "-", "-", "-"] ]
  end

  it "finds single letter words in the puzzle" do
    expect(snaking_include?("i", puzzle)).to be true
  end

  it "finds two-letter words" do
    expect(snaking_include?("ka", puzzle)).to be true
  end

  it "finds longer words in the puzzle" do
    expect(snaking_include?("nighthawks", puzzle)).to eq true
  end

  it "finds words that start in multiple places but are only found in one" do
    expect(snaking_include?("hat", puzzle)).to eq true
  end

  it "uses each space only once" do
    expect(snaking_include?("nin", puzzle)).to be false
  end

  it "returns false for empty strings" do
    expect(snaking_include?("", puzzle)).to be false
  end

  it "returns false when the first letter is not in the puzzle" do
    expect(snaking_include?("x", puzzle)).to be false
  end

  it "returns false when only the first part of the word can be found" do
    expect(snaking_include?("nightlight", puzzle)).to be false
  end
end

describe "coordinates_matching_letter" do
  it "returns a subset of coordinates whose letter matches the given letter" do
    puzzle = [
      ["a", "b"],
      ["b", "x"]
    ]

    letter = "b"
    coordinates_to_check = [
      { row: 0, column: 1 },
      { row: 1, column: 0 },
      { row: 1, column: 1 }
    ]

    expect(coordinates_matching_letter(letter, coordinates_to_check, puzzle)).to match_array [{ row: 0, column: 1 }, { row: 1, column: 0 }]
  end

  context "when no coordinates match the given letter" do
    it "is empty" do
    puzzle = [
      ["a", "b"],
      ["b", "x"]
    ]

    letter = "o"
    coordinates_to_check = [
      { row: 0, column: 1 },
      { row: 1, column: 0 },
      { row: 1, column: 1 }
    ]

    expect(coordinates_matching_letter(letter, coordinates_to_check, puzzle)).to be_empty
    end
  end
end

describe "letter_at_coordinates?" do
  let(:puzzle) do
    [ ["a", "x"],
      ["x", "x"] ]
  end

  it "returns true if the letter is found at the given coordinates" do
    coordinates = { row: 0, column: 0 }
    letter = "a"

    expect(letter_at_coordinates?(letter, coordinates, puzzle)).to be true
  end

  it "returns false if the letter is not found at the given coordinates" do
    coordinates = { row: 0, column: 0 }
    letter = "b"

    expect(letter_at_coordinates?(letter, coordinates, puzzle)).to be false
  end
end

describe "letter_at" do
  it "returns the letter at the given coordinates" do
    puzzle = [["a", "x"], ["x", "x"]]
    coordinates = { row: 0, column: 0 }

    expect(letter_at(coordinates, puzzle)).to eq "a"
  end
end

describe "coordinates_to_search" do
  let(:puzzle) do
    [ ["x", "x"],
      ["x", "x"] ]
  end

  it "returns all the coordinates when no coordinates are given" do
    all_coordinates = [
      { row: 0, column: 0},
      { row: 0, column: 1},
      { row: 1, column: 0},
      { row: 1, column: 1}
    ]

    expect(coordinates_to_search(puzzle)).to match_array all_coordinates
  end

  it "returns neighboring_coordinates when coordinates are given" do
    coordinates = { row: 0, column: 0 }

    neighboring_coordinates = [
      { row: 0, column: 1},
      { row: 1, column: 0},
      { row: 1, column: 1}
    ]

    expect(coordinates_to_search(coordinates, puzzle)).to match_array neighboring_coordinates
  end
end

describe "neighboring_coordinates" do
  let(:puzzle) do
    [ ["x", "x", "x"],
      ["x", "x", "x"],
      ["x", "x", "x"] ]
  end

  it "returns the coordinates of spaces neighboring a set of coordinates" do
    coordinates = { row: 1, column: 1 }
    neighbors = [
      { row: 0, column: 0 },
      { row: 0, column: 1 },
      { row: 0, column: 2 },
      { row: 1, column: 0 },
      { row: 1, column: 2 },
      { row: 2, column: 0 },
      { row: 2, column: 1 },
      { row: 2, column: 2 }
    ]

    expect(neighboring_coordinates(coordinates, puzzle)).to match_array neighbors
  end

  context "when the set of coordinates is on the edge of the puzzle" do
    it "does not include coodinates beyond the top of the puzzle" do
      coordinates = { row: 0, column: 1 }
      neighbors = [
        { row: 0, column: 0 },
        { row: 0, column: 2 },
        { row: 1, column: 0 },
        { row: 1, column: 1 },
        { row: 1, column: 2 }
      ]

      expect(neighboring_coordinates(coordinates, puzzle)).to match_array neighbors
    end

    it "does not include coordinates beyond the bottom of the puzzle" do
      coordinates = { row: 2, column: 1 }
      neighbors = [
        { row: 2, column: 0 },
        { row: 2, column: 2 },
        { row: 1, column: 0 },
        { row: 1, column: 1 },
        { row: 1, column: 2 }
      ]

      expect(neighboring_coordinates(coordinates, puzzle)).to match_array neighbors
    end

    it "does not include coordinates beyond the left side of the puzzle" do
      coordinates = { row: 1, column: 0 }
      neighbors = [
        { row: 0, column: 0 },
        { row: 0, column: 1 },
        { row: 1, column: 1 },
        { row: 2, column: 0 },
        { row: 2, column: 1 }
      ]

      expect(neighboring_coordinates(coordinates, puzzle)).to match_array neighbors
    end

    it "does not include coordinates beyond the right side of the puzzle" do
      coordinates = { row: 1, column: 2 }
      neighbors = [
        { row: 0, column: 2 },
        { row: 0, column: 1 },
        { row: 1, column: 1 },
        { row: 2, column: 2 },
        { row: 2, column: 1 }
      ]

      expect(neighboring_coordinates(coordinates, puzzle)).to match_array neighbors
    end
  end
end

describe "neighbor_rows" do
  let(:puzzle) do
    [ ["x", "x", "x"],
      ["x", "x", "x"],
      ["x", "x", "x"] ]
  end

  it "returns the row indexes of neighboring spaces for a set of coordinates" do
    coordinates = { row: 1, column: 1 }

    expect(neighbor_rows(coordinates, puzzle)).to match_array [0, 1, 2]
  end

  context "when the set of coordinates is on the edge of the puzzle" do
    it "does not include coodinates beyond the top of the puzzle" do
      coordinates = { row: 0, column: 1 }

      expect(neighbor_rows(coordinates, puzzle)).to match_array [0, 1]
    end

    it "does not include coordinates beyond the bottom of the puzzle" do
      coordinates = { row: 2, column: 1 }

      expect(neighbor_rows(coordinates, puzzle)).to match_array [1, 2]
    end
  end
end

describe "neighbor_columns" do
  let(:puzzle) do
    [ ["x", "x", "x"],
      ["x", "x", "x"],
      ["x", "x", "x"] ]
  end

  it "returns the column indexes of neighboring spaces for a set of coordinates" do
    coordinates = { row: 1, column: 1 }

    expect(neighbor_columns(coordinates, puzzle)).to match_array [0, 1, 2]
  end

  context "when the set of coordinates is on the edge of the puzzle" do
    it "does not include coodinates beyond the left side of the puzzle" do
      coordinates = { row: 1, column: 0 }

      expect(neighbor_columns(coordinates, puzzle)).to match_array [0, 1]
    end

    it "does not include coordinates beyond the right side of the puzzle" do
      coordinates = { row: 1, column: 2 }

      expect(neighbor_columns(coordinates, puzzle)).to match_array [1, 2]
    end
  end
end

describe "valid_row_indexes" do
  it "returns the row indexes in the puzzle" do
    puzzle = [ ["x", "x", "x"],
               ["x", "x", "x"],
               ["x", "x", "x"] ]

    expect(valid_row_indexes(puzzle)).to match_array [0, 1, 2]
  end
end

describe "valid_column_indexes" do
  it "returns the column indexes in the puzzle" do
    puzzle = [ ["x", "x", "x", "x"],
               ["x", "x", "x", "x"],
               ["x", "x", "x", "x"],
               ["x", "x", "x", "x"] ]

    expect(valid_column_indexes(puzzle)).to match_array [0, 1, 2, 3]
  end
end

describe "all_coordinates" do
  it "returns the coordinates of all spaces in the puzzle" do
    puzzle = [
      ["x", "x"],
      ["x", "x"]
    ]

    coordinates = [
      { row: 0, column: 0},
      { row: 0, column: 1},
      { row: 1, column: 0},
      { row: 1, column: 1}
    ]

    expect(all_coordinates(puzzle)).to match_array coordinates
  end
end

describe "mark_used" do
  let(:puzzle) do
    [ ["a", "b"],
      ["b", "x"] ]
  end

  let(:coordinates) do
    { row: 0, column: 1 }
  end

  it "marks coordinates on the board as used" do
    expect { mark_used(coordinates, puzzle) }.to change { puzzle.at(coordinates[:row]).at(coordinates[:column]) }.to("-")
  end

  it "returns the puzzle" do
    expect(mark_used(coordinates, puzzle)).to be puzzle
  end
end

describe "puzzle_copy" do
  let(:puzzle) do
    [ ["a", "b"],
      ["c", "d"] ]
  end

  it "is not the same object as the puzzle" do
    expect(puzzle_copy(puzzle)).to_not be puzzle
  end

  it "has the same letters in the same order as the original puzzle" do
    puzzle_letters = puzzle.flatten.join
    copy_letters = puzzle_copy(puzzle).flatten.join
    expect(puzzle_letters).to eq copy_letters
  end

  it "has the same number of rows as the original puzzle" do
    expect(puzzle_copy(puzzle).count).to eq puzzle.count
  end

  it "has rows with the same length as the original puzzle" do
    expect(puzzle_copy(puzzle).first.count).to eq puzzle.first.count
  end

  it "has rows that are different objects than the rows in the original" do
    expect(puzzle_copy(puzzle).first).to_not be puzzle.first
  end

  it "has rows that equal the rows in the original" do
    expect(puzzle_copy(puzzle).last).to eq puzzle.last
  end
end

describe "first_letter" do
  it "returns the first letter" do
    expect(first_letter("abc")).to eq "a"
  end
end

describe "trim" do
  it "removes the first letter" do
    expect(trim("abc")).to eq "bc"
  end
end
