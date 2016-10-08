# Somemoji

[![Gem Version](https://badge.fury.io/rb/somemoji.svg)](https://badge.fury.io/rb/somemoji)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/r7kamura/somemoji)
[![CircleCI](https://circleci.com/gh/r7kamura/somemoji.svg?style=svg)](https://circleci.com/gh/r7kamura/somemoji)

A grand unified emoji mapper for some emoji providers.

## Supported emoji

- [Apple Emoji](https://support.apple.com/en-us/HT202332)
- [EmojiOne](https://github.com/Ranks/emojione)
- [Noto Emoji](https://github.com/googlei18n/noto-emoji)
- [Twemoji](https://github.com/twitter/twemoji)

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

## Documentation

See API documentation at http://www.rubydoc.info/github/r7kamura/somemoji.

## Use case

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
