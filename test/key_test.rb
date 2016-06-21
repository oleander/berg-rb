require "test_helper"
require "json"

describe Berg do
  before do
    @data = JSON.parse(File.read("test/fixtures/data.json"))
  end

  it "searches using both keys and values" do
    query = ".context.dispatcher.stores.PageStore.pages./nrj/latlista.data[1].modules[2].content[0].title"
    value = "Fire in the Rain"

    # Get query for #{item} in #{data}
    result1 = Berg::Key.locate(@data) { |leaf| leaf.to_s.include?(value) }
    # Get value from #{query}
    result2 = Berg::Value.locate(@data, query)

    result1.value.must_equal(query)
    result2.value.must_equal(value)
  end

  describe Berg::Key do
    it "should not find anything" do
      Berg::Key.locate(@data) { false }.found?.must_equal(false)
    end
  end

  describe Berg::Value do
    it "should not find anything" do
      Berg::Value.locate(@data, "nothing").found?.must_equal(false)
    end

    it "should fail on debug" do
      proc {
        Berg::Value.locate(@data, "nothing", true)
      }.must_raise(RuntimeError)
    end
  end
end