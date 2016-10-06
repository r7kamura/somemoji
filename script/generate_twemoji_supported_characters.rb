require "json"
require "pathname"
require "somemoji"
require "twemoji"

Pathname.new(Somemoji.twemoji_supported_characters_path).parent.mkpath

characters = ::Twemoji.invert_codes.keys.map do |code_points_string|
  code_points_string.split("-").map do |code_point|
    code_point.to_i(16)
  end.pack("U*")
end

File.write(
  Somemoji.twemoji_supported_characters_path,
  JSON.pretty_generate(characters.sort),
)
