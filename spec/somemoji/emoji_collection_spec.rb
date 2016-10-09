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

  describe "#filter_by_category" do
    subject do
      ::Somemoji::EmojiCollection.new(
        [
          ::Somemoji::Emoji.new(category: "activity", code: "activity-1"),
          ::Somemoji::Emoji.new(category: "activity", code: "activity-2"),
          ::Somemoji::Emoji.new(category: "people", code: "people-1"),
        ]
      ).filter_by_category("activity")
    end

    it "returns a Somemoji::EmojiCollection filtered by a given category pattern" do
      expect(subject.count).to eq 2
    end
  end

  describe "#filter_by_keyword" do
    subject do
      ::Somemoji::EmojiCollection.new(
        [
          ::Somemoji::Emoji.new(code: "code1", keywords: %w(keyword1 keyword2)),
          ::Somemoji::Emoji.new(code: "code2", keywords: %w(keyword1 keyword2)),
          ::Somemoji::Emoji.new(code: "code3", keywords: %w(keyword2 keyword3)),
        ]
      ).filter_by_keyword("keyword1")
    end

    it "returns a Somemoji::EmojiCollection filtered by a given keyword pattern" do
      expect(subject.count).to eq 2
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
        %(<img alt="#{emoji.character}" class="emoji" src="/images/emoji/#{emoji.base_path}.png">)
      end
    end

    it "replaces :emoji_code: in a given string with a given block" do
      is_expected.to eq 'I <img alt="❤" class="emoji" src="/images/emoji/unicode/2764.png"> Emoji'
    end
  end

  describe "#replace_code" do
    subject do
      emoji_collection.replace_code("I :heart: Emoji") do |emoji|
        %(<img alt="#{emoji.character}" class="emoji" src="/images/emoji/#{emoji.base_path}.png">)
      end
    end

    it "replaces emoji characters in a given string with a given block" do
      is_expected.to eq 'I <img alt="❤" class="emoji" src="/images/emoji/unicode/2764.png"> Emoji'
    end
  end
end
