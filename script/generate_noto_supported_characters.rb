require "json"
require "net/https"
require "pathname"
require "somemoji"

http = ::Net::HTTP.new("api.github.com", 443)
http.use_ssl = true
response = http.get("/repos/googlei18n/noto-emoji/contents/png/128")
p response
characters = JSON.parse(response.body).map do |hash|
  if hash["name"].start_with?("emoji")
    hash["name"][7..-5].split("_").map do |point|
      point.to_i(16)
    end.pack("U*")
  end
end.compact

Pathname.new(Somemoji.noto_supported_characters_path).parent.mkpath
File.write(
  Somemoji.noto_supported_characters_path,
  JSON.pretty_generate(characters.sort),
)
