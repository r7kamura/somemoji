RSpec.describe Somemoji do
  describe ".emoji_collection" do
    subject do
      described_class.emoji_collection
    end

    it "returns a Somemoji::EmojiCollection" do
      is_expected.to be_a ::Somemoji::EmojiCollection
    end
  end
end
