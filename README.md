# Somemoji

A grand unified emoji mapper for some emoji providers.

## Supported emoji

- Apple Emoji
- [EmojiOne](http://emojione.com/)
- [Twemoji](http://twitter.github.io/twemoji/)

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

## Usage

### Somemoji.emoji_collection

Returns a `Somemoji::EmojiCollection` instance based on our emoji definitions.

```ruby
Somemoji.emoji_collection.class #=> Somemoji::EmojiCollection
Somemoji.emoji_collection.count #=> 1794
Somemoji.emoji_collection.first.class #=> Somemoji::Emoji
```

### Somemoji.apple_emoji_collection

Returns a `Somemoji::EmojiCollection` instance for Apple.

```ruby
Somemoji.apple_emoji_collection.count #=> 1285
```

### Somemoji.emoji_one_emoji_collection

Returns a `Somemoji::EmojiCollection` instance for EmojiOne.

```ruby
Somemoji.emoji_one_emoji_collection.count #=> 1794
```

### Somemoji.twemoji_emoji_collection

Returns a `Somemoji::EmojiCollection` instance for Twemoji.

```ruby
Somemoji.twemoji_emoji_collection.count #=> 1626
```

### Somemoji::EmojiCollection#find_by_character(character)

Finds a `Somemoji::Emoji` instance from an emoji character (unicode grapheme cluster).

```ruby
Somemoji.emoji_collection.find_by_character("👍").class #=> Somemoji::Emoji
Somemoji.emoji_collection.find_by_character("👎").class #=> Somemoji::Emoji
```

### Somemoji::EmojiCollection#find_by_code(code)

Finds a `Somemoji::Emoji` instance from an emoji code.

```ruby
Somemoji.emoji_collection.find_by_code("thumbsup").class #=> Somemoji::Emoji
Somemoji.emoji_collection.find_by_code("+1").class #=> Somemoji::Emoji
Somemoji.emoji_collection.find_by_code("undefined_code") #=> nil
```

### Somemoji::EmojiCollection#+(emoji_collection)

Compounds two `Somemoji::EmojiCollection` into one `Somemoji::EmojiCollection`.

```ruby
custom_emoji_collection = Somemoji.emoji_collection + Somemoji::EmojiCollection.new(
  [
    Somemoji::Emoji.new(code: "foo"),
    Somemoji::Emoji.new(code: "bar"),
  ]
)
custom_emoji_collection.find_by_code("foo").class #=> Somemoji::Emoji
custom_emoji_collection.find_by_code("bar").class #=> Somemoji::Emoji
custom_emoji_collection.find_by_code("100").class #=> Somemoji::Emoji
```

### Somemoji::EmojiCollection#replace_character(string, &block)

Replaces emoji characters in a given string with a given block.

```ruby
Somemoji.emoji_collection.replace_code("I ❤ Emoji") do |emoji|
  %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.code_points.join('-').downcase}.png">)
end
#=> 'I <img alt="❤" class="emoji" src="/assets/emoji/2764.png"> Emoji'
```

### Somemoji::EmojiCollection#replace_code(string, &block)

Replaces emoji codes in a given string with a given block.

```ruby
Somemoji.emoji_collection.replace_code("I :heart: Emoji") do |emoji|
  %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.code_points.join('-').downcase}.png">)
end
#=> 'I <img alt="❤" class="emoji" src="/assets/emoji/2764.png"> Emoji'
```

### Somemoji::EmojiCollection#filter_by_category(category)

Returns a Somemoji::EmojiCollection filtered by a given category.

```ruby
Somemoji.emoji_collection.filter_by_category("activity").count #=> 145
Somemoji.emoji_collection.filter_by_category("people").count #=> 570
```

### Somemoji::Emoji.new

Creates a new `Somemoji::Emoji` instance from emoji definition data.

```ruby
emoji = Somemoji::Emoji.new(
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
emoji.character #=> "💯"
```

### Somemoji::Emoji#character

Returns a String representation of an emoji if it has code points.

```ruby
Somemoji.emojis.first.character #=> "💯"
```
