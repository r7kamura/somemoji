require "fileutils"
require "json"
require "somemoji"

FileUtils.mkdir_p(Somemoji.emoji_definitions_directory_path)
specification = Gem::Specification.find_by_name("gemojione")
json = File.read("#{specification.gem_dir}/config/index.json")
index = JSON.parse(json)
index.each do |shortname, data|
  File.write(
    "#{Somemoji.emoji_definitions_directory_path}/#{shortname}.json",
    JSON.pretty_generate(
      aliases: data["aliases"].sort.map { |string| string[1..-2] },
      ascii_arts: data["aliases_ascii"].sort,
      category: data["category"],
      code: shortname,
      code_points: (data["unicode_alternates"].any? ? data["unicode_alternates"].first : data["unicode"]).split("-").map do |code_point|
        code_point.to_i(16).to_s(16)
      end,
      keywords: data["keywords"].sort,
      name: data["name"],
    ).gsub("[\n\n  ]", "[]"),
  )
end
