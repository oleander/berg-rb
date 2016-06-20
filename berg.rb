require "./key"
require "./value"
require "json"

data = JSON.parse(File.read("data.json"))
query = ".context.dispatcher.stores.PageStore.pages./nrj/latlista.data[1].modules[2].content[0].title"
value = "Fire in the Rain"

# Get query for #{item} in #{data}
found_query = Berg::Key.locate(data) do |leaf|
  leaf.to_s.include?(value)
end

# Get value from #{query}
found_value = Berg::Value.locate(data, query)

p [found_value == value, found_query == query]