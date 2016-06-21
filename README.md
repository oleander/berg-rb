[![Build Status](https://travis-ci.org/oleander/berg-rb.svg?branch=master)](https://travis-ci.org/oleander/berg-rb)

# Berg

Find paths and values in complex Ruby hashes – much like css selectors.

## Install

```
$ gem install berg
```

## Example

``` ruby
require "berg"

data = { ... }
query = ".data[1].modules[2].content[-1].title.name"
value = "My value"

# Get query for #{value} in #{data}
Berg::Key.locate(data) do |leaf|
  leaf.to_s.include?(value)
end

# Get value from #{query} in #{data}
Berg::Value.locate(data, query)
```