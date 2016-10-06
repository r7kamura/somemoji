RSpec.describe Somemoji::Emoji do
  let(:emoji) do
    described_class.new(
      aliases: [],
      ascii_arts: [],
      category: "symbols",
      code_points_alternates: [],
      code_points: [
        "1F4AF"
      ],
      code: "100",
      keywords: [
        "100",
        "a",
        "exam",
        "numbers",
        "parties",
        "percent",
        "perfect",
        "plus",
        "quiz",
        "school",
        "score",
        "symbol",
        "test",
        "win",
        "wow"
      ],
      name: "hundred points symbol"
    )
  end

  describe "#character" do
    subject do
      emoji.character
    end

    it "returns a main character representation" do
      is_expected.to eq "\u{1f4af}"
    end
  end
end
