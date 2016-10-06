RSpec.describe Somemoji::EmojiCollection do
  let(:emoji_collection) do
    ::Somemoji.emoji_collection
  end

  describe "#+" do
    subject do
      emoji_collection + another_emoji_collection
    end

    let(:another_emoji_collection) do
      described_class.new([custom_emoji])
    end

    let(:custom_emoji) do
      ::Somemoji::Emoji.new(code: custom_emoji_code)
    end

    let(:custom_emoji_code) do
      "custom_emoji_example"
    end

    it "returns a compound Somemoji::EmojiCollection" do
      expect(subject.find_by_code(custom_emoji_code)).to eq custom_emoji
    end
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

  describe "#replace_character" do
    subject do
      emoji_collection.replace_character("I ❤ Emoji") do |emoji|
        %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.code_points.join('-').downcase}.png">)
      end
    end

    it "replaces :emoji_code: in a given string with a given block" do
      is_expected.to eq 'I <img alt="❤" class="emoji" src="/assets/emoji/2764.png"> Emoji'
    end
  end

  describe "#replace_code" do
    subject do
      emoji_collection.replace_code("I :heart: Emoji") do |emoji|
        %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.code_points.join('-').downcase}.png">)
      end
    end

    it "replaces emoji characters in a given string with a given block" do
      is_expected.to eq 'I <img alt="❤" class="emoji" src="/assets/emoji/2764.png"> Emoji'
    end
  end
end
