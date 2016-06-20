# Berg

Find paths and values in complex Ruby hashes – much like css selectors.

## Example

See [example.rb](example.rb) for a runnable example.

``` ruby
require "berg"

data = { ... }
query = ".data[1].modules[2].content[-1].title.name"
value = "My value"

# Get query for #{item} in #{data}
found_query = Berg::Key.locate(data) do |leaf|
  leaf.to_s.include?(value)
end

# Get value from #{query}
found_value = Berg::Value.locate(data, query)

puts [found_value == value, found_query == query] # => [true, true]
```