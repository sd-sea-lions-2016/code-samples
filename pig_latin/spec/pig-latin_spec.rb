require_relative '../Pig-latin'

describe "Converting English to Pig Latin" do

  describe "#convert" do
    it "returns pig latinized single words" do
      expect(convert "abc").to eq "abc"
    end

    it "returns pig latinized sentences" do
      string = "\"That shouldn't work,\" I'd said."
      expect(convert string).to eq "\"Atthay ouldshayn't orkway,\" I'd aidsay."
    end
  end

  describe "#pigify" do
    it "doesn't change strings starting with a vowel" do
      expect(pigify "abc").to eq "abc"
      expect(pigify "ebc").to eq "ebc"
      expect(pigify "ibc").to eq "ibc"
      expect(pigify "obc").to eq "obc"
      expect(pigify "Ubc").to eq "Ubc"
    end

    it "handles strings beginning with a single consonant" do
      expect(pigify "bac").to eq "acbay"
    end

    it "handles strings beginning with multiple consonants" do
      expect(pigify "bbbac").to eq "acbbbay"
    end

    it "preserves punctuation at the beginning of strings" do
      expect(pigify "\"bac").to eq "\"acbay"
    end

    it "preserves puncuation at the end end of strings" do
      expect(pigify "abc\"").to eq "abc\""
    end

    it "preserves multiple punctuation marks" do
      expect(pigify "something,\"").to eq "omethingsay,\""
    end

    it "preserves capitalization at the beginning of words" do
      expect(pigify "Bac").to eq "Acbay"
    end

    it "preserves all capitalization and punctuation" do
      expect(pigify "\"Toad\"").to eq "\"Oadtay\""
    end

    context "with contractions" do
      it "it preserves n't" do
        expect(pigify "couldn't").to eq "ouldcayn't"
      end

      it "preserves 'd" do
        expect(pigify "he'd").to eq "ehay'd"
      end

      it "preserves 's" do
        expect(pigify "king's").to eq "ingkay's"
      end
    end
  end

  describe "#correct_capitalization" do
    it "returns the word if it contains no capital letters" do
      expect(correct_capitalization("abc")).to eq "abc"
    end

    it "returns the word if it starts with a capital letter" do
      expect(correct_capitalization("Abc")).to eq "Abc"
    end

    it "moves capitalization to the first letter if another letter is capitalized" do
      expect(correct_capitalization("aBc")).to eq "Abc"
    end
  end

  describe "#starts_with_vowel?" do
    it "returns true if the word starts with a lowercase a,e,i,o, or u" do
      expect(starts_with_vowel?("echo")).to be true
    end

    it "returns true if the word starts with a capital A,E,I,O, or U" do
      expect(starts_with_vowel?("Ideas")).to be true
    end

    it "returns false if the word starts with a consonant" do
      expect(starts_with_vowel?("nighthawks")).to be false
    end
  end
end
