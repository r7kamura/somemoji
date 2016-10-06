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

Returns an Array of `Somemoji::Emoji` instances based on our default dictionary.

```ruby
require "somemoji"

Somemoji.emojis.class #=> Array
Somemoji.emojis.length #=> 1794
Somemoji.emojis.first.class #=> Somemoji::Emoji
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
