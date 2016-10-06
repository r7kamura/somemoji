RSpec.describe Somemoji::EmojiCollection do
  let(:emoji_collection) do
    ::Somemoji.emoji_collection
  end

  describe "#find_by_character" do
    subject do
      emoji_collection.find_by_character(character)
    end

    let(:character) do
      "\u{2934}"
    end

    context "with emoji character" do
      it "finds a Somemoji::Emoji instance from an emoji character (unicode grapheme cluster)" do
        is_expected.to be_a ::Somemoji::Emoji
      end
    end

    context "with emoji character alternate" do
      let(:character) do
        "\u{2934}\u{FE0F}"
      end

      it "finds a Somemoji::Emoji instance from an emoji character alternate" do
        is_expected.to be_a ::Somemoji::Emoji
      end
    end
  end

  describe "#find_by_code" do
    subject do
      emoji_collection.find_by_code(code)
    end

    let(:code) do
      "thumbsup"
    end

    context "with emoji code" do
      it "finds a Somemoji::Emoji instance from an emoji code" do
        is_expected.to be_a ::Somemoji::Emoji
      end
    end

    context "with emoji code alias" do
      let(:code) do
        "+1"
      end

      it "finds a Somemoji::Emoji instance from an emoji code alias" do
        is_expected.to be_a ::Somemoji::Emoji
      end
    end
  end
end
