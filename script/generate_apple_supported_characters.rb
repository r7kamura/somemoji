require "emoji/extractor"
require "fileutils"
require "json"
require "pathname"
require "somemoji"
require "tmpdir"

Pathname.new(Somemoji.apple_supported_characters_path).parent.mkpath

temporary_directory_path = Dir.tmpdir
unicode_directory_path = "#{temporary_directory_path}/unicode"
Emoji::Extractor.new(64, temporary_directory_path).extract!

table = Somemoji.emoji_collection.each_with_object({}) do |emoji, object|
  object[emoji.abbreviated_code_points] = emoji
  object[emoji.code_points] = emoji
end

emojis = Dir.glob("#{unicode_directory_path}/*.png").map do |image_path|
  code_points = ::File.basename(image_path, ".png").split("-").map do |code_point|
    code_point.to_i(16).to_s(16)
  end
  table[code_points]
end.compact

FileUtils.rm_rf(unicode_directory_path)

open(Somemoji.apple_supported_characters_path, "w") do |file|
  file.puts(JSON.pretty_generate(emojis.map(&:character).uniq.sort))
end
