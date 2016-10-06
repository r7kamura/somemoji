RSpec.describe Somemoji do
  describe ".emoji_collection" do
    subject do
      described_class.emoji_collection
    end

    it "returns a Somemoji::EmojiCollection" do
      is_expected.to be_a ::Somemoji::EmojiCollection
    end
  end

  describe ".emoji_one_emoji_collection" do
    subject do
      described_class.emoji_one_emoji_collection
    end

    it "returns a Somemoji::EmojiCollection" do
      is_expected.to be_a ::Somemoji::EmojiCollection
    end
  end

  describe ".twemoji_emoji_collection" do
    subject do
      described_class.twemoji_emoji_collection
    end

    it "returns a Somemoji::EmojiCollection" do
      is_expected.to be_a ::Somemoji::EmojiCollection
    end
  end
end
