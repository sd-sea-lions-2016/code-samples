# Toggle commenting out the lines below to test the refactored vs minimal code
require_relative '../word_search'
# require_relative '../word_search_minimal'

PUZZLE = [
  ["a", "k", "f", "o", "x", "e", "s"],
  ["s", "o", "a", "w", "a", "h", "p"],
  ["i", "t", "c", "k", "e", "t", "n"],
  ["o", "t", "s", "d", "h", "o", "h"],
  ["s", "e", "x", "g", "s", "t", "a"],
  ["u", "r", "p", "i", "w", "e", "u"],
  ["z", "s", "b", "n", "u", "i", "r"]
]

SMALL_PUZZLE = [
  ["a", "k", "f"],
  ["s", "o", "a"],
  ["i", "t", "c"]
]

SMALL_PUZZLE_FORWARD_DIAGONALS = [
  ['i'],
  ['s', 't'],
  ['a', 'o', 'c'],
  ['k', 'a'],
  ['f']
]

SMALL_PUZZLE_BACKWARD_DIAGONALS = [
  ['a'],
  ['k', 's'],
  ['f', 'o', 'i'],
  ['a', 't'],
  ['c']
]

describe 'straight_line_include?' do
  it "should find foxes" do
    expect(straight_line_include?("foxes", PUZZLE)).to be true
  end

  it "should find otters" do
    expect(straight_line_include?("otters", PUZZLE)).to be true
  end

  it "should find bison" do
    expect(straight_line_include?("bison", PUZZLE)).to be true
  end
end

describe 'forward_diagonals_from' do
  it 'should find correct forward diagonals' do
    expect(forward_diagonals_from(SMALL_PUZZLE)).to eq SMALL_PUZZLE_FORWARD_DIAGONALS
  end
end

describe 'backward_diagonals_from' do
  it 'should find correct backward diagonals' do
    expect(backward_diagonals_from(SMALL_PUZZLE)).to eq SMALL_PUZZLE_BACKWARD_DIAGONALS
  end
end

describe 'snaking_include?' do
end
