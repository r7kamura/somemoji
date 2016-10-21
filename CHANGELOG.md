## v0.4.6

- Fix twemoji extractor so that missing emojis are now downloadable

## v0.4.5

- Improve `Somemoji::EmojiCollection#search_by_code` so that it matches with aliases

## v0.4.4

- Support `Somemoji::EmojiCollection#search_by_code`

## v0.4.3

- Support `Somemoji::Emoji#to_hash`

## v0.4.2

- Support slop both v3 and v4

## v0.4.1

- Add more available emojis on Noto emojis

## v0.4.0

- Add `somemoji` executable to extract emoji images

## v0.3.2

- Fix bug: nil.map raises error on no code_points emoji :bug:
- Change Somemoji::Emoji#character so that it may return nil

## v0.3.1

- Add Noto emoji extractor
- Use down-cased file name for extracted emoji
- Print progress on downloading emojis

## v0.3.0

- Support Noto emoji

## v0.2.0

- Support Apple emoji
- Implement emoji extractors for Apple, EmojiOne, and Twemoji

## v0.1.0

- 1st Release :tada:
