# Somemoji

A grand unified emoji mapper for some emoji providers.

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

### Somemoji.emojis

Returns an Array of `Somemoji::Emoji` instances based on our emoji definitions.

```ruby
require "somemoji"

Somemoji.emojis.class #=> Array
Somemoji.emojis.length #=> 1794
Somemoji.emojis.first.class #=> Somemoji::Emoji
```

### Somemoji.emoji_collection

Returns a `Somemoji::EmojiCollection` instance based on our emoji definitions.

```ruby
require "somemoji"

Somemoji.emoji_collection.class #=> Somemoji::EmojiCollection
Somemoji.emoji_collection.count #=> 1794
Somemoji.emoji_collection.first.class #=> Somemoji::Emoji
```

### Somemoji::EmojiCollection#find_by_code(code)

Finds a `Somemoji::Emoji` instance from an emoji code.

```ruby
require "somemoji"

Somemoji.emoji_collection.find_by_code("thumbsup").class #=> Somemoji::Emoji
Somemoji.emoji_collection.find_by_code("+1").class #=> Somemoji::Emoji
Somemoji.emoji_collection.find_by_code("undefined_code") #=> nil
```

### Somemoji::Emoji.new

Create a new `Somemoji::Emoji` instance from emoji definition data.

```ruby
require "somemoji"

emoji = Somemoji::Emoji.new(
  aliases: [],
  ascii_arts: [],
  category: "symbols",
  code_points_alternates: [],
  code_points: [
    "1F4AF"
  ],
  code: "100",
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
emoji.to_s #=> "💯"
```

### Somemoji::Emoji#to_s

Returns a String representation of an emoji if it has code points.

```ruby
require "somemoji"

Somemoji.emojis.first.to_s #=> "💯"
```
