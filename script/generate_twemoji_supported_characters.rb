require "json"
require "pathname"
require "somemoji"
require "twemoji"

Pathname.new(Somemoji.twemoji_supported_characters_path).parent.mkpath

table = Somemoji.emoji_collection.each_with_object({}) do |emoji, object|
  object[emoji.abbreviated_code_points] = emoji
  object[emoji.code_points] = emoji
end

emojis = ::Twemoji.invert_codes.keys.map do |code_points_string|
  code_points = code_points_string.split("-").map do |code_point|
    ("%04X" % code_point.to_i(16)).upcase
  end
  table[code_points]
end.compact

File.write(
  Somemoji.twemoji_supported_characters_path,
  JSON.pretty_generate(emojis.map(&:character).uniq.sort),
)
