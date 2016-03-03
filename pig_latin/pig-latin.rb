VOWEL_AT_START = /\A[aeiou]/i

A_CAPITAL_LETTER = /[A-Z]/

PARTS_OF_THE_WORD = %r{
  \A
  (?<lead_punctuation>\W+)?
  (?<lead_consonants>[^aeiou]+)?
  (?<base>\w*?)
  (?<contraction>\'\w+\z|n\'t)?
  (?<end_punctuation>\W+)?
  \z
}xi

def convert(string)
  string.split.map { |individual_word| pigify(individual_word) }.join(" ")
end

def pigify(word)
  return word if starts_with_vowel?(word)

  word.sub(PARTS_OF_THE_WORD) do
    "#{$~[:lead_punctuation]}#{correct_capitalization($~[:base] + $~[:lead_consonants])}ay#{$~[:contraction]}#{$~[:end_punctuation]}"
  end
end

def correct_capitalization(word)
  return word unless word.match(A_CAPITAL_LETTER)
  word.downcase.capitalize
end

def starts_with_vowel?(word)
  !!word.match(VOWEL_AT_START)
end
