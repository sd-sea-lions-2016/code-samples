require_relative '../straight_line_include'

describe '#straight_line_include?' do
  let(:puzzle) do
    [ ["a", "k", "f", "o", "x", "e", "s"],
      ["s", "o", "a", "w", "a", "h", "p"],
      ["i", "t", "c", "k", "e", "t", "n"],
      ["o", "t", "s", "d", "h", "o", "h"],
      ["s", "e", "x", "g", "s", "t", "a"],
      ["u", "r", "p", "i", "w", "e", "u"],
      ["z", "s", "b", "n", "u", "i", "r"] ]
  end

  it "finds words in a row spelled left to right" do
    expect(straight_line_include?("foxes", puzzle)).to be true
  end

  it "finds words in a row spelled right to left" do
    expect(straight_line_include?("riunbs", puzzle)).to be true
  end

  it "does not find words that are not in a row" do
    expect(straight_line_include?("akfyxes", puzzle)).to be false
  end

  it "finds words in a column top to bottom" do
    expect(straight_line_include?("otters", puzzle)).to be true
  end

  it "finds words in a column bottom to top" do
    expect(straight_line_include?("ietothe", puzzle)).to be true
  end

  it "does not find words that are not in a column" do
    expect(straight_line_include?("asiosux", puzzle)).to be false
  end

  it "finds words in a diagonal from top right to bottom left" do
    expect(straight_line_include?("shed", puzzle)).to be true
  end

  it "finds words in a diagonal from bottom left to top right" do
    expect(straight_line_include?("bison", puzzle)).to be true
  end

  it "finds words in a diagonal from top left to bottom right" do
    expect(straight_line_include?("khtu", puzzle)).to be true
  end

  it "finds words in a diagonal from bottom right to top left" do
    expect(straight_line_include?("brs", puzzle)).to be true
  end

  it "does not find words that are not in a diagonal" do
    expect(straight_line_include?("itxia", puzzle)).to be false
  end
end

describe "#joined_rows" do
  it "combines letters in each row to a string" do
    puzzle = [["a", "b"], ["c", "d"]]
    expect(joined_rows(puzzle)).to eq ["ab", "cd"]
  end
end

describe "#joined_rows_reversed" do
  it "combines letters in each row to a string with the order reversed" do
    puzzle = [["a", "b"], ["c", "d"]]
    expect(joined_rows_reversed(puzzle)).to eq ["ba", "dc"]
  end
end

describe "#joined_columns" do
  it "combines letters in each column to a string" do
    puzzle = [["a", "b"], ["c", "d"]]
    expect(joined_columns(puzzle)).to eq ["ac", "bd"]
  end
end

describe "#joined_uphill_diagonals" do
  it "combines letters in each bottom-left to top-right diagonal" do
    puzzle = [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]
    expect(joined_uphill_diagonals(puzzle)).to eq ["a", "db", "gec", "hf", "i"]
  end
end

describe "#joined_downhill_diagonals" do
  it "combines letters in each top-left to bottom-right diagonal" do
    puzzle = [["a", "b", "c"],
              ["d", "e", "f"],
              ["g", "h", "i"]]
    expect(joined_downhill_diagonals(puzzle)).to eq ["g", "dh", "aei", "bf", "c"]
  end
end

describe "#top_right_to_bottom_left_diagonals" do
  it "returns a collection with rows of each top-right to bottom-left diagonal" do
    puzzle = [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]
    diagonals = [ ["a"], ["b", "d"], ["c", "e", "g"], ["f", "h"], ["i"] ]

    expect(top_right_to_bottom_left_diagonals(puzzle)).to eq diagonals
  end
end

describe "#top_right_to_bottom_left_diagonals_in_columns" do
  it "pads rows to align diagonals into columns" do
    puzzle = [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]

    aligned_diagonals = [
      ["a", "b", "c", nil, nil],
      [nil, "d", "e", "f", nil],
      [nil, nil, "g", "h", "i"]
    ]

    expect(top_right_to_bottom_left_diagonals_in_columns(puzzle)).to eq aligned_diagonals
  end
end

describe "#pad_back" do
  it "returns a collection of the target size with nils at indexes not in original" do
    numbers = [1, 2, 3]
    expect(pad_back(numbers, 10)).to eq [1, 2, 3, nil, nil, nil, nil, nil, nil, nil]
  end
end

describe "#pad_front" do
  it "returns a collection of the target size with nils filling the front" do
    numbers = [1, 2, 3]
    expect(pad_front(numbers, 10)).to eq [nil, nil, nil, nil, nil, nil, nil, 1, 2, 3]
  end
end

describe "#size_diff" do
  it "returns the difference between the collection size and the target size" do
    numbers = [1, 2, 3]
    expect(size_diff(numbers, 5)).to eq 2
  end
end
