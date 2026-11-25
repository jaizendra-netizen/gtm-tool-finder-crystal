require "spec"
require "../src/gtm-tool-finder"

describe GtmToolFinder do
  it "loads the whole index" do
    GtmToolFinder.all.size.should eq 287
  end

  it "finds Apollo first" do
    GtmToolFinder.search("apollo", "", 5).first.url.should start_with("https://www.onegtmlab.dev/")
  end

  it "filters by kind" do
    hits = GtmToolFinder.search("clay", "comparison", 10)
    hits.should_not be_empty
    hits.all? { |e| e.kind == "Comparison" }.should be_true
  end

  it "returns nothing for a nonsense query" do
    GtmToolFinder.search("zzzznotatool").should be_empty
  end
end
