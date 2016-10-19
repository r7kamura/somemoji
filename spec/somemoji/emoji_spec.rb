RSpec.describe Somemoji::Emoji do
  let(:emoji) do
    described_class.new(
      aliases: [],
      ascii_arts: [],
      category: "symbols",
      code: "100",
      code_points: [
        "1F4AF"
      ],
      code_points_alternates: [],
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

  describe "#to_hash" do
    subject do
      emoji.to_hash
    end

    it "returns a Hash" do
      is_expected.to be_a ::Hash
    end
  end
end
