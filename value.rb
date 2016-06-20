module Berg
  class Value < Struct.new(:object, :query)
    ARRAY_ID = /\[(\d+)\]/

    def self.locate(object, query)
      new(object, query).locate[0]
    end

    def locate
      query.split(/\.|(\[\d+\])/).reject(&:empty?).inject([object, ""]) do |(latest, result), key|
        found = case key
        when ARRAY_ID
          latest[$1.to_i]
        else
          latest[key] || latest[key.to_sym]
        end

        found or raise "#{latest.class} does not respond to '#{key}' in '#{query}'"
        [found, add(result, key)]
      end
    end

    def add(current, key)
      current << (key.match(ARRAY_ID) ? key : ".#{key}")
    end
  end

  class Found < Struct.new(:query)
    def found?; true; end
  end

  class NotFound
    def found?; false; end
    def query; nil end
  end
end