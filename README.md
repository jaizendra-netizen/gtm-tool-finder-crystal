# gtm-tool-finder

Search the [OneGTMLab](https://www.onegtmlab.dev) GTM tool directory from Crystal or your terminal:

- API reviews for 66 sales and marketing tools: pricing, rate limits, keys and MCP support
- 99 head-to-head tool comparisons, such as Apollo vs Clay
- 110 plain-English definitions of GTM terms

## Installation

Add the shard to your `shard.yml`:

```yaml
dependencies:
  gtm-tool-finder:
    github: jaizendra-netizen/gtm-tool-finder-crystal
```

## Usage

```crystal
require "gtm-tool-finder"

GtmToolFinder.search("enrichment", "Tool", 10).each do |e|
  puts "#{e.name} #{e.url}"
end
```

From a checkout, `crystal run src/cli.cr -- apollo` or `crystal run src/cli.cr -- --kind comparison clay` prints matches with their links.

Every result links to the full page on [onegtmlab.dev/tool-directory](https://www.onegtmlab.dev/tool-directory). The list is compiled into the shard, so it works offline and sends no data anywhere.

Also available as a [Python package](https://pypi.org/project/gtm-tool-finder/), a [Ruby gem](https://rubygems.org/gems/gtm-tool-finder), an [Elixir package](https://hex.pm/packages/gtm_tool_finder) and a [Gleam package](https://hex.pm/packages/gtm_tool_directory). Built by [OneGTMLab](https://www.onegtmlab.dev), a GTM engineering agency. MIT licensed.
