def prime_factors(number)
  return [] if number < 2

  prime_factor = lowest_prime_factor(number)
  [prime_factor] + prime_factors(number / prime_factor)
end

def lowest_prime_factor(number)
  return nil if number < 2

  possible_factors_not_one_and_self(number).each do |possible_factor|
    if prime?(possible_factor) and evenly_divisible?(number, possible_factor)
      return possible_factor
    end
  end

  number
end

def possible_factors_not_one_and_self(number)
  if number <= 2
    []
  else
    end_of_range = [(number / 2), 2].max
    (2..end_of_range).to_a
  end
end

def prime?(number)
  return false if number < 2

  possible_factors_not_one_and_self(number).each do |possible_factor|
    return false if evenly_divisible?(number, possible_factor)
  end

  true
end

def evenly_divisible?(numerator, denominator)
  (numerator % denominator).zero?
end
