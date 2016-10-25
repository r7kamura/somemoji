require "emoji/extractor"
require "fileutils"
require "pathname"
require "somemoji"
require "tmpdir"

Pathname.new(Somemoji.apple_supported_characters_path).parent.mkpath

temporary_directory_path = Dir.tmpdir
unicode_directory_path = "#{temporary_directory_path}/unicode"
Emoji::Extractor.new(64, temporary_directory_path).extract!

table = Somemoji.emoji_collection.each_with_object({}) do |emoji, object|
  object[emoji.abbreviated_code_points] = emoji
end

emojis = Dir.glob("#{unicode_directory_path}/*.png").map do |image_path|
  table[::File.basename(image_path, ".png").upcase.split("-")]
end.compact

FileUtils.rm_rf(unicode_directory_path)

File.write(
  Somemoji.apple_supported_characters_path,
  JSON.pretty_generate(emojis.map(&:character).uniq.sort),
)
