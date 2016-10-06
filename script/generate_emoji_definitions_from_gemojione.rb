require "fileutils"
require "json"
require "somemoji"

FileUtils.mkdir_p("data")
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
      code_points: data["unicode"].split("-"),
      code_points_alternates: data["unicode_alternates"].sort.map { |string| string.split("-") },
      keywords: data["keywords"].sort,
      name: data["name"],
    ).gsub("[\n\n  ]", "[]"),
  )
end
