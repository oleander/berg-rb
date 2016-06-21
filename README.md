# Berg

Find paths and values in complex Ruby hashes – much like css selectors.

## Install

```
$ gem install berg
```

## Example

See [example.rb](example.rb) for a runnable example.

``` ruby
require "berg"

data = { ... }
query = ".data[1].modules[2].content[-1].title.name"
value = "My value"

# Get query for #{item} in #{data}
result1 = Berg::Key.locate(data) do |leaf|
  leaf.to_s.include?(value)
end

# Get value from #{query}
result2 = Berg::Value.locate(data, query)
```