require "emoji/extractor"
require "fileutils"
require "pathname"
require "somemoji"
require "tmpdir"

Pathname.new(Somemoji.apple_supported_characters_path).parent.mkpath

temporary_directory_path = Dir.tmpdir
unicode_directory_path = "#{temporary_directory_path}/unicode"
Emoji::Extractor.new(64, temporary_directory_path).extract!
characters = Dir.glob("#{unicode_directory_path}/*.png").map do |image_path|
  ::File.basename(image_path, ".png").split("-").map do |code_point|
    code_point.to_i(16)
  end.pack("U*")
end
FileUtils.rm_rf(unicode_directory_path)

File.write(
  Somemoji.apple_supported_characters_path,
  JSON.pretty_generate(characters.sort),
)
