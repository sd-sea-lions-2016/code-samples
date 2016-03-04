require_relative '../prime_factors'

describe '#prime_factors' do
  it "is empty if the number is less than two" do
    expect(prime_factors(1)).to be_empty
  end

  it "returns a collection containing only the number if the number is prime" do
    expect(prime_factors(7)).to match_array [7]
  end

  it "returns a collection representing the number's prime factorization" do
    expect(prime_factors(4)).to match_array [2, 2]
    expect(prime_factors(8)).to match_array [2, 2, 2]
    expect(prime_factors(12056)).to match_array [2, 2, 2, 11, 137]
  end
end

describe "#prime?" do
  it "returns false if the number is less than two" do
    expect(prime?(1)).to be false
  end

  it "returns true if the number is prime" do
    expect(prime?(2)).to be true
    expect(prime?(7)).to be true
  end

  it "returns false if the number is not prime" do
    expect(prime?(9)).to be false
  end
end

describe "#evenly_divisible?" do
  it "returns true if the first number is evenly divisible by the second" do
    expect(evenly_divisible?(4, 2)).to be true
  end

  it "returns false if the first number is not evenly divisible by the second" do
    expect(evenly_divisible?(5, 2)).to be false
  end
end

describe "#possible_factors_not_one_and_self" do
  context "number is less than or equal to two" do
    it "is empty" do
      expect(possible_factors_not_one_and_self(1)).to be_empty
      expect(possible_factors_not_one_and_self(2)).to be_empty
    end
  end

  context "number is greater than two" do
    it "returns integers from two to half the number" do
      expect(possible_factors_not_one_and_self(9)).to eq (2..4).to_a
      expect(possible_factors_not_one_and_self(10)).to eq (2..5).to_a
    end

    it "contains at least a two" do
      expect(possible_factors_not_one_and_self(3)).to eq [2]
      expect(possible_factors_not_one_and_self(4)).to eq [2]
    end
  end
end

describe "#lowest_prime_factor" do
  it "returns the lowest prime factor of the given number" do
    expect(lowest_prime_factor(4)).to eq 2
    expect(lowest_prime_factor(25)).to eq 5
  end

  it "returns the number if the number is prime" do
    expect(lowest_prime_factor(17)).to eq 17
  end

  it "returns nil if the number is less than two" do
    expect(lowest_prime_factor(1)).to eq nil
  end
end
