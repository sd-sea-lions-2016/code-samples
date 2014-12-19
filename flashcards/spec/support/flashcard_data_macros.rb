module FlashcardDataMacros
  def stub_read_flashcard_data
    allow(File).to receive(:readlines) do
      ["first prompt\n", "first answer\n", "\n", "second prompt\n", "second answer\n", "\n"]
    end
  end
end
