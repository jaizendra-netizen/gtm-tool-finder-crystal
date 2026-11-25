require "./gtm-tool-finder"

kind = ""
limit = 20
words = [] of String
args = ARGV.dup
until args.empty?
  a = args.shift
  case a
  when "--kind"  then kind = args.shift? || ""
  when "--limit" then limit = (args.shift? || "20").to_i? || 20
  else                words << a
  end
end

hits = GtmToolFinder.search(words.join(" "), kind, limit)
if hits.empty?
  puts "No matches."
  exit 1
end
hits.each { |e| puts "#{e.kind}: #{e.name}\n  #{e.url}" }
