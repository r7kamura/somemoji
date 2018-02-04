RSpec.describe Somemoji::Emoji do
  let(:emoji) do
    described_class.new(
      aliases: [],
      ascii_arts: [],
      category: "nature",
      code: "sunny",
      code_points: [
        "2600",
        "fe0f"
      ],
      keywords: [
        "brightness",
        "day",
        "hot",
        "morning",
        "sky",
        "sun",
        "weather"
      ],
      name: "black sun with rays"
    )
  end

  describe "#abbreviated_code_points" do
    subject do
      emoji.abbreviated_code_points
    end

    it "returns abbreviated code points" do
      is_expected.to eq ["2600"]
    end
  end

  describe "#character" do
    subject do
      emoji.character
    end

    it "returns a main character representation" do
      is_expected.to eq "\u{2600}\u{fe0f}"
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
