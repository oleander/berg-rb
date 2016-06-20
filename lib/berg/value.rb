module Berg
  class Value < Struct.new(:object, :query)
    ARRAY_ID = /\[(\d+)\]/

    def self.locate(object, query)
      new(object, query).locate
    end

    def locate
      result, _ = keys.inject([object, ""]) do |(latest, trace), key|
        found = case key
        when ARRAY_ID
          latest[$1.to_i]
        else
          latest[key] || latest[key.to_sym]
        end

        return NotFound.new unless found
        [found, add(trace, key)]
      end

      return Found.new(result)
    end

    private

    def keys
      query.split(/\.|(\[\d+\])/).reject(&:empty?)
    end

    def add(trace, key)
      trace << (key.match(ARRAY_ID) ? key : ".#{key}")
    end
  end
end