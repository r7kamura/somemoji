# Somemoji

[![Gem Version](https://badge.fury.io/rb/somemoji.svg)](https://badge.fury.io/rb/somemoji)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/r7kamura/somemoji)
[![CircleCI](https://circleci.com/gh/r7kamura/somemoji.svg?style=svg)](https://circleci.com/gh/r7kamura/somemoji)

A grand unified emoji mapper for some emoji providers.

## Supported emoji

- [Apple Emoji](https://support.apple.com/en-us/HT202332) (1,285 emojis, Licensed by Apple Inc.)
- [EmojiOne](https://github.com/Ranks/emojione) (1,794 emojis, CC-BY 4.0)
- [Noto Emoji](https://github.com/googlei18n/noto-emoji) (1,541 emojis, SIL Open Font License 1.1)
- [Twemoji](https://github.com/twitter/twemoji) (1,626 emojis, CC-BY 4.0)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "somemoji"
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install somemoji
```

## Command line tool

`somemoji` executable is bundled to extract images from each emoji provider.

```
$ somemoji --help
Usage: somemoji extract [options]
    -p, --provider     (required) apple, emoji_one, noto, or twemoji
    -d, --destination  (required) directory path to locate extracted image files
    -f, --format       png or svg (default: png)
    -s, --size         Some providers have different size image files
    -h, --help         Display this help message
```

e.g. To extract emojis from Twemoji into ./images/emoji directory, execute:

```bash
somemoji extract --provider=twemoji --destination=./images/emoji
```

## Use cases

### Replace emoji codes

```ruby
Somemoji.emoji_one_emoji_collection.replace_code("I :heart: Emoji") do |emoji|
  %(<img alt="#{emoji.character}" class="emoji" src="/images/emoji/#{emoji.base_path}.png">)
end
#=> 'I <img alt="❤" class="emoji" src="/images/emoji/unicode/2764.png"> Emoji'
```

### Replace emoji characters

```ruby
Somemoji.noto_emoji_collection.replace_character("I 💗 Emoji") do |emoji|
  %(<img alt="#{emoji.character}" class="emoji" src="/images/emoji/#{emoji.base_path}.png">)
end
#=> 'I <img alt="💗" class="emoji" src="/images/emoji/unicode/1f497.png"> Emoji'
```

### Custom emojis

```ruby
custom_emoji_collection = Somemoji.emoji_one_emoji_collection + Somemoji::EmojiCollection.new(
  [
    Somemoji::Emoji.new(code: "foo"),
    Somemoji::Emoji.new(code: "bar"),
  ]
)
custom_emoji_collection.find_by_code("foo").class #=> Somemoji::Emoji
custom_emoji_collection.find_by_code("bar").class #=> Somemoji::Emoji
custom_emoji_collection.find_by_code("100").class #=> Somemoji::Emoji
custom_emoji_collection.replace_code("I :bar: Emoji") do |emoji|
  %(<img alt="#{emoji.character || emoji.code}" class="emoji" src="/images/emoji/#{emoji.base_path}.png">)
end #=> 'I <img alt="bar" class="emoji" src="/images/emoji/bar.png"> Emoji'
```

### HTML::Pipeline integration

```ruby
class EmojiFilter < ::HTML::Pipeline::Filter
  IGNORED_ANCESTOR_ELEMENT_NAMES = %w(
    code
    pre
    tt
  )

  # @note Implementation for HTML::Pipeline::Filter
  def call
    doc.search(".//text()").each do |node|
      unless has_ancestor?(node, IGNORED_ANCESTOR_ELEMENT_NAMES)
        node.replace(
          ::Somemoji.twemoji_emoji_collection.replace_code(node.to_html) do |emoji|
            %W(
              <img
                alt="#{emoji.code}"
                class="emoji"
                height="20"
                src="/images/emoji/#{emoji.base_path}.png"
                title=":#{emoji.code}:"
                width="20">
            ).join(" ")
          end
        )
      end
    end
    doc
  end
end
```

## Documentation

See API documentation at http://www.rubydoc.info/github/r7kamura/somemoji.
