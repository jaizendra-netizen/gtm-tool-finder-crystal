require "json"

# Search the [OneGTMLab](https://www.onegtmlab.dev) GTM tool directory
# (https://www.onegtmlab.dev/tool-directory): API reviews of sales and marketing
# tools, head-to-head comparisons and plain-English GTM glossary terms.
#
# The index is compiled into the shard, so it works offline and sends no data anywhere.
module GtmToolFinder
  VERSION = "1.0.0"

  # One page of the directory.
  struct Entry
    include JSON::Serializable

    # Page title.
    @[JSON::Field(key: "n")]
    getter name : String
    # Tool, Category, Comparison or Glossary.
    @[JSON::Field(key: "k")]
    getter kind : String
    # Link to the full page on onegtmlab.dev.
    @[JSON::Field(key: "u")]
    getter url : String
    # One-sentence description.
    @[JSON::Field(key: "d")]
    getter description : String
  end

  KIND_ORDER = {"Tool" => 0, "Category" => 1, "Comparison" => 2, "Glossary" => 3}

  @@entries : Array(Entry)? = nil

  # Every entry in the directory.
  def self.all : Array(Entry)
    @@entries ||= Array(Entry).from_json({{ read_file("#{__DIR__}/../data/index.json") }})
  end

  # Entries whose name or description contains every word of *query*.
  # *kind* filters by Tool, Category, Comparison or Glossary (case-insensitive, empty means all).
  # *limit* caps the result count (0 or less means 20).
  def self.search(query : String, kind : String = "", limit : Int32 = 20) : Array(Entry)
    limit = 20 if limit <= 0
    words = query.downcase.split.reject(&.empty?)
    hits = all.select do |e|
      next false unless kind.empty? || e.kind.downcase == kind.downcase
      text = "#{e.name} #{e.description}".downcase
      words.all? { |w| text.includes?(w) }
    end
    first = words.first?
    ranked = hits.map_with_index do |e, i|
      starts = first && e.name.downcase.starts_with?(first) ? 0 : 1
      {starts, KIND_ORDER[e.kind]? || 4, i, e}
    end
    ranked.sort_by { |r| {r[0], r[1], r[2]} }.first(limit).map { |r| r[3] }
  end
end
